package;

import kha.math.FastVector2;
class SGBoxCollider implements SGCollider{
	var parent: SGObject;

	public function new(parent: SGObject) {
		this.parent = parent;
	}

	public function CheckCollision(other: SGBoxCollider) {
		var pos = parent.transform.GetPosition();
		var topLeft     = pos.add(new FastVector2(-parent.size.x * 0.5, -parent.size.y * 0.5)); 
		var topRight    = pos.add(new FastVector2( parent.size.x * 0.5, -parent.size.y * 0.5));
		var bottomLeft  = pos.add(new FastVector2(-parent.size.x * 0.5,  parent.size.y * 0.5));
		var bottomRight = pos.add(new FastVector2( parent.size.x * 0.5,  parent.size.y * 0.5));

		
	}
}