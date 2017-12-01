package;

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

	function new(){
		position = new FastVector2(0,0);
		size = new FastVector2(0,0);
		vel = new FastVector2(0,0);
		angle = 0;
		rotation = FastMatrix3.identity();
		translation = FastMatrix3.identity();
	}

}