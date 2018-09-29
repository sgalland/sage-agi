package sage.agi.resources;

import sage.agi.EAGIFileName;
import sage.agi.resources.AGIDirectoryEntry;
import sage.agi.resources.AGIFile;
import sys.FileSystem;
import haxe.io.Path;
import sys.io.File;
import sys.io.FileSeek;

class AGIFileReader {
	private var directoryEntries:Array<AGIDirectoryEntry> = new Array<AGIDirectoryEntry>();

	public function new() {}

	public function loadDirectoryEntries(fileType:EAGIFileName) {
		var agiFileType:String = AGIFileNameTools.getFileName(fileType);

		var path = new Path(Path.join([Sys.getCwd(), agiFileType]));
		if (!sys.FileSystem.exists(path.toString()))
			throw 'File $agiFileType cannot be found.\n$path';

		var file = File.read(path.toString(), true);
		var fileSize = FileSystem.stat(path.toString());
		var resourceCount = 0;
		var directoryEntries = new Array<AGIDirectoryEntry>();
		while (file.tell() < fileSize.size) {
			var b1 = file.readByte(); // 8bit unsigned
			var b2 = file.readByte(); // 8bit unsigned
			var b3 = file.readByte(); // 8bit unsigned

			var directoryEntry = new AGIDirectoryEntry();
			directoryEntry.volNumber = (b1 & 0xF0) >> 4;
			directoryEntry.dataOffset = ((b1 & 0x0F) << 16) + ((b2 & 0xFF) << 8) + (b3 & 0xFF);

			if (directoryEntry.isEmpty()) {
				directoryEntry.resourceID = resourceCount;
				directoryEntries.push(directoryEntry);
			}

			resourceCount++;
		}
		file.close();

        this.directoryEntries = directoryEntries;
	}

	public function getFile(resourceID:Int):AGIFile {
		if (resourceID < 0 || resourceID > 255) {
			throw "resourceID value $resourceID must be between 0 and 255.";
		} else if (resourceID > directoryEntries.length) {
			throw "resourceID value $resourceID does not exist.";
		}

		var dirEntry:AGIDirectoryEntry = directoryEntries.filter(function(entry) {
			return entry.resourceID == resourceID;
		})[0];

		var path = new Path(Path.join([Sys.getCwd(), "VOL." + Std.string(dirEntry.volNumber)]));
		if (!sys.FileSystem.exists(path.toString()))
			throw 'File cannot be found.\n$path';

		var file = File.read(path.toString(), true);

		file.seek(dirEntry.dataOffset, FileSeek.SeekBegin);
		dirEntry.signature = file.readInt16(); // 16bit signed int
		var agiFile:AGIFile = new AGIFile();

		if (dirEntry.isValid()) {
			agiFile.resourceID = resourceID;
			agiFile.volNumber = file.readByte(); // uint8_t
			var b1 = file.readByte(); // uint8_t
			var b2 = file.readByte(); // uint8_t
			agiFile.fileSize = b1 + (b2 << 8); // int16 signed

			agiFile.data = file.read(agiFile.fileSize);
            trace(agiFile.data.get(0));
            trace(agiFile.data.get(1));
            trace(agiFile.data.get(2));
		}

		file.close();

		return agiFile;
	}
}
