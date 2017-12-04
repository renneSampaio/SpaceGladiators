package;

import kha.graphics2.Graphics;
import kha.math.FastMatrix3;
import kha.math.FastVector2;
import kha.FastFloat;

class SGTransform{
	private var position:FastVector2;
	private var size:FastVector2;
	private var vel:FastVector2;
	private var angle:FastFloat;
	private var rotation:FastMatrix3;
	private var translation:FastMatrix3;

	public function new(){
		position = new FastVector2(0,0);
		size = new FastVector2(0,0);
		vel = new FastVector2(0,0);
		angle = 0;
		rotation = FastMatrix3.rotation(angle);
		translation = FastMatrix3.translation(position.x, position.y);
	}

	public function SetPosition(pos: FastVector2) {
		position = pos;
	}

	public function SetSize(s: FastVector2) {
		size = s;
	}

	public function SetAngle(a: Float) {
		angle = a;
	}
	
	public function Rotate(a: Float) {
		angle += a;
	}

	public function Translate(ammount: FastVector2) {
		position.add(ammount);
	}

	public function Apply(g: Graphics): Void {
		rotation = FastMatrix3.rotation(angle);
		translation = FastMatrix3.translation(position.x, position.y);

		var transformation = translation.multmat(rotation);

		g.pushTransformation(transformation);
	}

}