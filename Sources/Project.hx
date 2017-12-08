package;

import kha.graphics2.Graphics;
import kha.Framebuffer;
import kha.Assets;
import kha.Scheduler;
import kha.System;
import kha.input.Keyboard;
import kha.Color;
import kha.input.KeyCode;
import kha.math.FastMatrix3;
import kha.math.FastVector2;

using kha.graphics2.GraphicsExtension;

class Project {
	
	var ship: SGShip;
	var ship2: SGShip;

	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);

		Restart();

		SGInputManager.Get().AddUpObserver(KeyCode.R, Restart);
	}

	function Restart() {
		ship = new SGShip(System.windowWidth(0)/1.25, System.windowHeight(0)/2, 5./60, 1);
		ship2 = new SGShip(System.windowWidth(0)/4.75, System.windowHeight(0)/2, 5./60, 2);

		ship.SetEnemy(ship2);
		ship2.SetEnemy(ship);
	}

	function update(): Void {
		ship.update();
		ship2.update();
	}

	function render(framebuffer: Framebuffer): Void {
		var g2 = framebuffer.g2;
		g2.begin(false);
			g2.color = Color.fromBytes(0, 0, 0, 20);
			g2.fillCircle(0,0, 10000);

			ship.render(g2);
			ship2.render(g2);

			if (ship.GetActive() && ship2.GetActive()) {
				DrawPlayerInfo(g2);
			} else {
				DrawGameOverMessage(g2);
			}
		g2.end();
	}

	function DrawPlayerInfo(g2: Graphics) {
		g2.color = ship.GetColor();
		g2.font = Assets.fonts.Kenney_Mini_Square;
		g2.fontSize = 25;
		g2.drawString("Player  I:   " + ship.GetHP(), 20, 20);

		g2.color = ship2.GetColor();
		g2.fontSize = 25;
		g2.drawString("Player II:   " + ship2.GetHP(), 20, 50);
	}

	function DrawGameOverMessage(g2: Graphics) {
		g2.font = Assets.fonts.Kenney_Blocks;
		g2.fontSize = 50;
		g2.drawString("PRESS R TO RESTART", (System.windowWidth(0)/2)-200, System.windowHeight(0)/2);
	}
}
