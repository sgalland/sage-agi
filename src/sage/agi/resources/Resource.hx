package sage.agi.resources;

class Resource {
	private var file:AGIFile;
	private var resourceID:Int;

	public var loaded:Bool;

	public function new(file:AGIFile, resourceID:Int) {
		this.file = file;
		this.resourceID = resourceID;
	}
}
