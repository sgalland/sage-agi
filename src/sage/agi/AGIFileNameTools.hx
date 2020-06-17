package sage.agi;

using haxe.EnumTools;
import sage.agi.AGIResourceType;
/**
 Class of static functions used for working with the AGIResourceType enumeration.
 **/
class AGIFileNameTools {
    /**
     * Converts a AGIResourceType enum value into the filename.
     * @param fileType 
     */
    public static function getFileName(fileType:AGIResourceType):String {
        return switch(fileType) {
            case AGIResourceType.AGIDATA: "AGIDATA.OVL";
            case AGIResourceType.VIEW: "VIEWDIR";
            case AGIResourceType.SOUND: "SNDDIR";
            case AGIResourceType.LOGIC: "LOGDIR";
            case AGIResourceType.PICTURE: "PICDIR";
            default: Std.string(fileType);
        }
    }
}