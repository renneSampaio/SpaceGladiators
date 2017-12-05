package;

using kha.math.FastVector2;

class SGObject {
	var transform:SGTransform;
	var size: FastVector2;

	public function new() {
		transform = new SGTransform();
	}

	function update():Void {}
	function render():Void {}
}