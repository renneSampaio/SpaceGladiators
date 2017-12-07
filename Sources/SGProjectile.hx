package;

import kha.graphics2.Graphics;
import kha.FastFloat;
import kha.math.FastVector2;

class SGProjectile extends SGObject {
	private var shooter: SGObject;
	private var vel: FastVector2;
	private var speed: FastFloat;

	public function new(shooter: SGObject, vel: FastVector2) {
		super();

		this.shooter = shooter;
		this.vel = vel;
		this.size = new FastVector2(10,10);

		transform.SetPosition(shooter.transform.GetPosition());
		transform.SetAngle(transform.GetAngle());
	}

	public override function update() {
		transform.Translate(vel);
	} 

	public override function render(g: Graphics) {
			g.pushTransformation(transform.GetTransformation());

				g.drawRect(0, 0, size.x, size.y);

			g.popTransformation();
	}

	//public function ColisaoBala():Bool{
	//	if()
	//}
}