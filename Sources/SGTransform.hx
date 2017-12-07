package;

import kha.math.FastMatrix3;
import kha.math.FastVector2;
import kha.FastFloat;

class SGTransform{
	private var position:FastVector2;
	private var angle:FastFloat;
	private var rotation:FastMatrix3;
	private var translation:FastMatrix3;

	public function new(){
		position = new FastVector2(0,0);
		angle = 0;
		rotation = FastMatrix3.rotation(angle);
		translation = FastMatrix3.translation(position.x, position.y);
	}

	public function SetPosition(pos: FastVector2) {
		position = pos;
	}

	public function GetPosition(): FastVector2 {
		return new FastVector2(position.x, position.y);
	}

	public function SetAngle(a: Float) {
		angle = a;
	}

	public function GetAngle(): FastFloat{
		return this.angle;
	}

	public function Rotate(a: Float) {
		angle += a;
	}

	public function GetRotation(): FastMatrix3 {
		return FastMatrix3.rotation(angle);
	}

	public function GetTranslation(): FastMatrix3 {
		return FastMatrix3.translation(position.x, position.y);
	}

	public function Translate(ammount: FastVector2) {
		position = position.add(ammount);
	}

	public function GetTransformation(): FastMatrix3 {
		rotation = GetRotation();
		translation = GetTranslation();

		var transformation = translation.multmat(rotation);

		//g.pushTransformation(transformation);
		return transformation;
	}

}