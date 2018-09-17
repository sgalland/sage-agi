package sage.agi.resources;
import sage.agi.EAGIFileName;
import sage.agi.resources.AGIDirectoryEntry;
import sys.FileSystem;
import haxe.io.Path;
import sys.io.File;

class AGIFileReader {

    public function new() {        
    }

    public function loadDirectoryEntries(fileType:EAGIFileName) {
        var agiFileType:String = AGIFileNameTools.getFileName(fileType);

        var path = new Path(Path.join([Sys.getCwd(), agiFileType]));
        if (!sys.FileSystem.exists(path.toString()))
            throw 'File $agiFileType cannot be found.\n$path';

        var file = File.read(path.toString(), true);
        var fileSize = FileSystem.stat(path.toString());
        var resourceCount = 0;
        var directoryEntries = new Array<AGIDirectoryEntry>();
        while(file.tell() < fileSize.size) {
            var b1 = file.readByte(); // 8bit unsigned
            var b2 = file.readByte(); // 8bit unsigned
            var b3 = file.readByte(); // 8bit unsigned
            
            var directoryEntry = new AGIDirectoryEntry();
            directoryEntry.volNumber = (b1 & 0xF0) >> 4;
            directoryEntry.dataOffset =
                ((b1 & 0x0F) << 16) +
				((b2 & 0xFF) << 8) +
				(b3 & 0xFF);
            
            if(directoryEntry.isEmpty()) {
                directoryEntry.resourceID = resourceCount;
                directoryEntries.push(directoryEntry);
            }

            resourceCount++;
        }
        file.close();

        return directoryEntries;
    }
}