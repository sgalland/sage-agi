package sage.agi;

import haxe.io.Path;
import sys.io.File;
import sage.agi.EAGIFileName;
import sage.core.StringExtender;

/**
 Version of the AGI game engine. 
 The version number is stored as an ASCII string in the AGIDATA.OVL file.

 The version number is represented as a string as major.minor.revision

 @see http://wiki.scummvm.org/index.php/Sierra_Game_Versions 
 **/
 @:export
class AGIVersion {

    public static inline var MIN_AGI_VERSION = 0;
    public static inline var MAX_AGI_VERSION = 3;

    public function new(version:String) {
        this.parseVersion(version);
    }

    private function parseVersion(version:String) {
        var tokens = version.split('.');
        validateTokens(tokens);

        if (tokens.length >= 2) {
            this.major = Std.parseInt(tokens[0]);
            this.minor = Std.parseInt(tokens[1]);
        }

        if (tokens.length == 3) {
            this.revision = Std.parseInt(tokens[2]);
        }
    }

    private function validateTokens(tokens:Array<String>) {
        if (tokens.length < 2 || tokens.length > 3)
            throw "AGIVersion requires that the version number have both a major and minor number. i.e. 2.492";

        for(token in tokens) {
            if(Std.parseInt(token) == null)
                throw "AGIVersion requires that each part of the version number be an integer.";
        }
    }

    /**
     Indicates the major number of the AGI version. The only major versions created by Sierra
     are versions 0 though 3.
     **/
    @:isVar public var major(default, set) :Int;
    function set_major(value) {
        if (value < MIN_AGI_VERSION)
            throw 'The minimum AGI version number is $MIN_AGI_VERSION';

        if (value > MAX_AGI_VERSION)
            throw 'The maximum AGI version number is $MAX_AGI_VERSION';

        return major = value;
    }

    /**
     Indicates the minor version number.
     **/
    @:isVar public var minor(default, default) : Int;

    /**
     Indicates the revision number. Only games running on AGI v3 have a revision number.
     **/
    @:isVar public var revision(default, default):Null<Int>;

    public function toString() {
        var displayMinor:String = StringTools.lpad(Std.string(minor), "0", 3);
        var displayRevision:String = StringTools.lpad(Std.string(revision), "0", 3);
        var displayFormat:String = '$major.$displayMinor';

        if (revision != null)
            displayFormat = '$displayFormat.$displayRevision';
        
        return displayFormat;
    }

    private static inline var searchString:String = "Version ";

    /**
     * Reads the AGIDATA.OVL file and generates an object representing the AGIVersion.
     * @return AGIVersion
     */
    public static function getVersion() : AGIVersion {
        var version:String = "";
        var versionBuffer:String = new String("00000000");
        var isVersionFound = false;
        var agiDataFileName = EAGIFileName.AGIDATA;

        var path = new Path(Path.join([Sys.getCwd(), agiDataFileName]));
        if (!sys.FileSystem.exists(path.toString()))
            throw 'File $agiDataFileName cannot be found.\n$path';

        var file = File.read(path.toString(), true);
        while (!file.eof()) {
            var c:String = String.fromCharCode(file.readByte());

            if (isVersionFound) {
                if (c.charCodeAt(0) == StringExtender.NULL_CHAR)
                    break;
                version += c;
            } else {
                versionBuffer = versionBuffer.substr(1, 7) + c;
                isVersionFound = versionBuffer.indexOf(searchString) != -1;
            }
        }
        file.close();

        return new AGIVersion(version);
    }
}