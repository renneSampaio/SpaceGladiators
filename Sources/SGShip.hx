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

	public function new(x: FastFloat, y: FastFloat, speed: FastFloat) {
		super();
		transform.SetPosition(new FastVector2(x, y));
		this.vel = new FastVector2(0, 0);
		this.size = new FastVector2(20, 30);
		this.speed = speed;

		Keyboard.get().notify(ActivateEngine, DeactivateEngine);
	}

	public function ActivateEngine(key: KeyCode ) {
		switch(key) {
			case KeyCode.Numpad7: right    = true;
			case KeyCode.Numpad9: left     = true;
			case KeyCode.Numpad8: backward = true;
			case KeyCode.Numpad2: forward  = true;
			default:
		}
	}

	public function DeactivateEngine(key: KeyCode) {
		switch(key) {
			case KeyCode.Numpad7: right    = false;
			case KeyCode.Numpad9: left     = false;
			case KeyCode.Numpad8: backward = false;
			case KeyCode.Numpad2: forward  = false;
			default:
		}
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