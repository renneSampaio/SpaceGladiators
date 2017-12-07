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

	public function new(x: FastFloat, y: FastFloat, speed: FastFloat, playerNumber: Int) {
		super();
		transform.SetPosition(new FastVector2(x, y));
		this.vel = new FastVector2(0, 0);
		this.size = new FastVector2(20, 30);
		this.speed = speed;

		bullets = new Array<SGProjectile>();

		var playerKeys = {left: KeyCode.F13, right: KeyCode.F13, forward: KeyCode.F13, backward: KeyCode.F13, fire: KeyCode.F13};

		if (playerNumber == 1) {
			playerKeys.right   = KeyCode.Numpad9; playerKeys.left     = KeyCode.Numpad7;
			playerKeys.forward = KeyCode.Numpad8; playerKeys.backward = KeyCode.Numpad2;
			playerKeys.fire    = KeyCode.Numpad5;
		} else {
			playerKeys.right   = KeyCode.E; playerKeys.left       = KeyCode.Q;
			playerKeys.forward = KeyCode.W; playerKeys.backward = KeyCode.X;
			playerKeys.fire    = KeyCode.S;
		}

		SGInputManager.Get().AddUpDownObserver(playerKeys.right, function () { this.right    = true;}, function () { this.right    = false;});
		SGInputManager.Get().AddUpDownObserver(playerKeys.left, function () { this.left     = true;}, function () { this.left     = false;});
		SGInputManager.Get().AddUpDownObserver(playerKeys.forward, function () { this.forward  = true;}, function () { this.forward  = false;});
		SGInputManager.Get().AddUpDownObserver(playerKeys.backward, function () { this.backward = true;}, function () { this.backward = false;});

		SGInputManager.Get().AddUpObserver(playerKeys.fire, FireBullet);
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