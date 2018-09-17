package sage.agi.resources;

/**
 A directory entry of a resource file. Resources are stored in VOL.x 
 files where x is read from the directory entry. The directory entry contains
 the offset of the vol file of where the data for the resources is located.
 **/
class AGIDirectoryEntry {
    private static inline var EMPTY_DIRECTORY:Int = 0xFFFFF;
    private static inline var VALID_SIGNATURE:Int = 0x3412;

    public function new() {

    }

    /**
     Signature for the resource. If the signature matches the valid signature
     then the data can be used to load a resource.

     16bit unsigned integer
     **/
    public var signature(default, default):Int;

    /**
     Indicates what VOL file the resource is stored in.

     8bit unsigned integer
     **/
    public var volNumber(default, default):Int;

    /**
     Offset of the VOL file to locate the data for the resource.

     32bit unsigned integer
     **/
    public var dataOffset(default, default):Int;
    
    /**
     A number assigned to the resource for indexing.

     8bit unsigned integer
     **/
    public var resourceID(default, default):Int;

    /**
     Indicates if the directory entry contains actual game data.
     **/
    public function isEmpty():Bool {
        return dataOffset != EMPTY_DIRECTORY;
    }
}