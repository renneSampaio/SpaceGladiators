package;

import kha.graphics2.Graphics;
using kha.math.FastVector2;

class SGObject{
	private static var _id = 0;
	public var id(default, never) = _id++; 
	public var transform:SGTransform;
	private var size: FastVector2;
	private var active: Bool;

	public function new() {
		transform = new SGTransform();
		active = true;
	}

	public function SetActive(newactive:Bool){
		this.active = newactive; 
	}
	public function GetActive():Bool{
		return active;
	}

	function update():Void {}
	function render(g: Graphics):Void {}
}