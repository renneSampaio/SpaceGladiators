package;

import kha.graphics2.Graphics;
import kha.FastFloat;
import kha.math.FastVector2;

class SGProjectile extends SGObject {
	private var shooter: SGShip;
	private var vel: FastVector2;
	private var speed: FastFloat;
	private var enemy: SGShip;

	public function new(shooter: SGShip, enemy: SGShip ,vel: FastVector2) {
		super();

		this.shooter = shooter;
		this.enemy = enemy;
		this.vel = vel;
		this.size = new FastVector2(5,5);

		transform.SetPosition(shooter.transform.GetPosition());
		transform.SetAngle(shooter.transform.GetAngle());
	}

	public override function update() {
		transform.Translate(vel);
		CheckCollision();
	} 

	public override function render(g: Graphics) {
		if (active) {
			g.pushTransformation(transform.GetTransformation());

				g.drawRect(size.x * -0.5, -shooter.size.y, size.x, size.y);

			g.popTransformation();
		}
	}

	public function CheckCollision()
	{
		var pos = transform.GetPosition();
		var otherPos = enemy.transform.GetPosition();

		var topLeft     = pos.add(new FastVector2(-enemy.size.x * 0.5, -enemy.size.y * 0.5)); 
		var topRight    = pos.add(new FastVector2( enemy.size.x * 0.5, -enemy.size.y * 0.5));
		var bottomLeft  = pos.add(new FastVector2(-enemy.size.x * 0.5,  enemy.size.y * 0.5));
		var bottomRight = pos.add(new FastVector2( enemy.size.x * 0.5,  enemy.size.y * 0.5));

		if (otherPos.x > topLeft.x && otherPos.y > topRight.y &&
			otherPos.x < topRight.x && otherPos.y < bottomRight.y)
		{
			this.active = false;
			enemy.OnHit();
		}
	}
}