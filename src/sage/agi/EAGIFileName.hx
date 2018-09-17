package sage.agi;

using haxe.EnumTools;
/**
 Enumeration detailing all the normal file types for an AGI game files.

 Note that VOL files are numbered and are not standardized since they differ per game. 
 **/
enum EAGIFileName {
    AGIDATA;
    LOGIC;
    VIEW;
    PICTURE;
    SOUND;
    WORDS;
}