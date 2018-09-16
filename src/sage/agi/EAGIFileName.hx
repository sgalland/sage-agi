package sage.agi;

/**
 Enumeration detailing all the normal filenames for AGI game files.

 Note that VOL files are numbered and are not standardized since they differ per game. 
 **/
@:enum abstract EAGIFileName(String) to String {
    var AGIDATA = "AGIDATA.OVL";
}