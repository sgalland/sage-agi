package sage.agi.resources;

import sys.FileSystem;
import sage.agi.AGIResourceType;
import haxe.io.Path;
import sys.io.File;
import sys.io.FileSeek;

/**
	Reads directory entries and allows the retrival of AGIFile from a VOL file.
**/
class AGIFileReader {
	/**
		List of AGIDirectoryEntry read from the VOL file.
	**/
	public var directoryEntries:Array<AGIDirectoryEntry> = new Array<AGIDirectoryEntry>();

	public function new() {}

	public function loadDirectoryEntries(fileType:AGIResourceType) {
		var agiFileType:String = AGIFileNameTools.getFileName(fileType);

		var path = new Path(Path.join([Sys.getCwd(), agiFileType]));
		if (!sys.FileSystem.exists(path.toString()))
			throw 'File $agiFileType cannot be found.\n$path';

		var file = File.read(path.toString(), true);
		var fileSize = FileSystem.stat(path.toString());
		var resourceCount = 0;
		var tempDirectoryEntries = new Array<AGIDirectoryEntry>();
		while (file.tell() < fileSize.size) {
			var b1 = file.readByte();
			var b2 = file.readByte();
			var b3 = file.readByte();

			var directoryEntry = new AGIDirectoryEntry();
			directoryEntry.volNumber = (b1 & 0xF0) >> 4;
			directoryEntry.dataOffset = ((b1 & 0x0F) << 16) + ((b2 & 0xFF) << 8) + (b3 & 0xFF);

			if (directoryEntry.isEmpty()) {
				directoryEntry.resourceID = resourceCount;
				tempDirectoryEntries.push(directoryEntry);
				trace("volume: "
					+ directoryEntry.volNumber
					+ " filepos:"
					+ directoryEntry.dataOffset
					+ " resourceid:"
					+ directoryEntry.resourceID);
			}

			resourceCount++;
		}
		file.close();

		this.directoryEntries = tempDirectoryEntries;
	}

	public function getFile(resourceID:Int):AGIFile {
		if (resourceID < 0 || resourceID > 255) {
			throw 'resourceID value $resourceID must be between 0 and 255.';
		}

		var dirEntry:AGIDirectoryEntry = directoryEntries.filter(function(entry) {
			return entry.resourceID == resourceID;
		})[0];

		if (dirEntry == null)
			return null;

		var path = new Path(Path.join([Sys.getCwd(), "VOL." + Std.string(dirEntry.volNumber)]));
		if (!sys.FileSystem.exists(path.toString()))
			throw 'File cannot be found.\n$path';

		var file = File.read(path.toString(), true);

		file.seek(dirEntry.dataOffset, FileSeek.SeekBegin);
		dirEntry.signature = file.readInt16();
		var agiFile:AGIFile = new AGIFile();

		if (dirEntry.isValid()) {
			agiFile.resourceID = resourceID;
			agiFile.volNumber = file.readByte();
			var b1 = file.readByte();
			var b2 = file.readByte();
			agiFile.fileSize = b1 + (b2 << 8);

			for (i in 0...agiFile.fileSize) {
				agiFile.data.push(file.readByte());
			}
		}

		file.close();

		return agiFile;
	}
}
