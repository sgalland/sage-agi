package sage.agi.menu;

class Menu {
	public function new(name:String) {
		this.name = name;
		this.modifiable = true;
	}

	public var modifiable:Bool; 
	
	public var name:String;

	public var next:Menu;

	public var items:Array<MenuItem> = new Array<MenuItem>();
	// TODO: Document this class
}
