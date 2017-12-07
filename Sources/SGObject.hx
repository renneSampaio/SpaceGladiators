package;

import kha.graphics2.Graphics;
using kha.math.FastVector2;

class SGObject {
	private static var _id = 0;
	public var id(default, never) = _id++; 
	var transform:SGTransform;
	var size: FastVector2;

	public function new() {
		transform = new SGTransform();
	}

	function update():Void {}
	function render(g: Graphics):Void {}
}