package;

import kha.graphics2.Graphics;
using kha.math.FastVector2;

class SGObject implements SGCollidable{
	private static var _id = 0;
	public var id(default, never) = _id++; 
	public var transform:SGTransform;
	public var size: FastVector2;
	var collider: SGBoxCollider;

	public function new() {
		transform = new SGTransform();
	}

	function update():Void {}
	function render(g: Graphics):Void {}
	public function OnCollision(other: SGObject): Void {}
}