package;

import kha.graphics2.Graphics;
using kha.math.FastVector2;

class SGObject{
	private static var _id = 0;
	public var id(default, never) = _id++; 
	public var transform:SGTransform;
	public var size: FastVector2;
	public var active: Bool;

	public function new() {
		transform = new SGTransform();
		active = true;
	}

	function update():Void {}
	function render(g: Graphics):Void {}
}