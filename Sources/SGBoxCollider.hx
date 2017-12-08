package;

import kha.math.FastVector2;
class SGBoxCollider implements SGCollider{
	var parent: SGObject;

	public function new(parent: SGObject) {
		this.parent = parent;
	}

	public function CheckCollision(other: SGObject) {
		var pos = parent.transform.GetPosition();
		var otherPos = other.transform.GetPosition();

		var topLeft     = pos.add(new FastVector2(-parent.size.x * 0.5, -parent.size.y * 0.5)); 
		var topRight    = pos.add(new FastVector2( parent.size.x * 0.5, -parent.size.y * 0.5));
		var bottomLeft  = pos.add(new FastVector2(-parent.size.x * 0.5,  parent.size.y * 0.5));
		var bottomRight = pos.add(new FastVector2( parent.size.x * 0.5,  parent.size.y * 0.5));

		if (otherPos.x > topLeft.x && otherPos.y > topRight.y &&
			otherPos.x < topRight.x && otherPos.y < bottomRight.y)
		{
			other.OnCollision(parent);
		}
	}
}