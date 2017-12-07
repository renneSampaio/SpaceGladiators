package;

import kha.graphics2.Graphics;
using kha.graphics2.GraphicsExtension;
import kha.System;
import kha.FastFloat;
import kha.input.Keyboard;
import kha.input.KeyCode;

using kha.math.FastVector2;

class SGShip extends SGObject {
	var vel: FastVector2;
	var speed: FastFloat;
	var forward: Bool;
	var backward: Bool;
	var left: Bool;
	var right: Bool;

	public var bullets: Array<SGProjectile>;

	public function new(x: FastFloat, y: FastFloat, speed: FastFloat) {
		super();
		transform.SetPosition(new FastVector2(x, y));
		this.vel = new FastVector2(0, 0);
		this.size = new FastVector2(20, 30);
		this.speed = speed;

		bullets = new Array<SGProjectile>();

		SGInputManager.Get().AddUpDownObserver(KeyCode.Numpad7, function () { this.right    = true;}, function () { this.right    = false;});
		SGInputManager.Get().AddUpDownObserver(KeyCode.Numpad9, function () { this.left     = true;}, function () { this.left     = false;});
		SGInputManager.Get().AddUpDownObserver(KeyCode.Numpad2, function () { this.forward  = true;}, function () { this.forward  = false;});
		SGInputManager.Get().AddUpDownObserver(KeyCode.Numpad8, function () { this.backward = true;}, function () { this.backward = false;});

		SGInputManager.Get().AddUpObserver(KeyCode.Numpad5, FireBullet);
	}

	public function FireBullet() {
		trace("Atirei!");
		bullets.push(new SGProjectile(this, transform.GetRotation().multvec(new FastVector2(0, -speed*50))));
	}

	public override function update() {
			if (right)
				transform.Rotate(5/System.refreshRate);
			if (left)
				transform.Rotate(-5/System.refreshRate);
			if (backward)
				vel = vel.add(transform.GetRotation().multvec(new FastVector2(0, speed)));
			if (forward)
				vel = vel.add(transform.GetRotation().multvec(new FastVector2(0, -speed)));
		
		transform.Translate(vel);

	}

	public override function render(g: Graphics) {
		g.pushTransformation(transform.GetTransformation());
			g.drawRect( -size.x/2, -size.y/2, size.x, size.y, 2);
			g.drawRect( -2.5, -size.y/2, 5, 10, 5);
			g.drawCircle(0, size.y/2, 10, 2);
		g.popTransformation();
	}
}