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
		this.size = new FastVector2(5,5);

		transform.SetPosition(shooter.transform.GetPosition());
		transform.SetAngle(shooter.transform.GetAngle());
	}

	public override function update() {
		transform.Translate(vel);
	} 

	public override function render(g: Graphics) {
			g.pushTransformation(transform.GetTransformation());

				g.drawRect(size.x * -0.5, -shooter.size.y, size.x, size.y);

			g.popTransformation();
	}

	//public function ColisaoBala():Bool{
	//	if()
	//}
}