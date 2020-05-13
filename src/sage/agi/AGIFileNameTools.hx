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
    public static function getFileName(fileType:EAGIFileName) {
        var returnValue:String;
        switch(fileType) {
            case EAGIFileName.AGIDATA: returnValue = "AGIDATA.OVL";
            case EAGIFileName.VIEW: returnValue = "VIEWDIR";
            case EAGIFileName.SOUND: returnValue = "SNDDIR";
            case EAGIFileName.LOGIC: returnValue = "LOGDIR";
            default: returnValue = Std.string(fileType);
        }

        return returnValue;
    }
}