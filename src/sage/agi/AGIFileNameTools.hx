package sage.agi;

using haxe.EnumTools;
import sage.agi.EAGIFileName;
/**
 Class of static functions used for working with the EAGIFileName enumeration.
 **/
class AGIFileNameTools {
    /**
     * Converts a EAGIFileName enum value into the filename.
     * @param fileType 
     */
    public static function getFileName(fileType:EAGIFileName):String {
        return switch(fileType) {
            case EAGIFileName.AGIDATA: "AGIDATA.OVL";
            case EAGIFileName.VIEW: "VIEWDIR";
            case EAGIFileName.SOUND: "SNDDIR";
            case EAGIFileName.LOGIC: "LOGDIR";
            case EAGIFileName.PICTURE: "PICDIR";
            default: Std.string(fileType);
        }
    }
}