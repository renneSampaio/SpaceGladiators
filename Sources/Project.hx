package;

import kha.Framebuffer;
import kha.Assets;
import kha.Scheduler;
import kha.System;
import kha.input.Keyboard;
import kha.input.KeyCode;

using kha.graphics2.GraphicsExtension;

class Project {
	
	var playerPos = {x: System.windowWidth(0)/2, y: System.windowHeight(0)/2};
	var playerSize = {width: 20, height: 40};
	var keysPressed = {_7: false, _8: false, _9: false, _1: false, _2: false, _3: false}
	var playerVel = {x: 0., y: 0.};
	var playerSpeed = {x: 5./60, y: 5./60};

	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		
		if (Keyboard.get() != null) Keyboard.get().notify(OnKeyDown, OnKeyUp);
	}

	function OnKeyDown(key: KeyCode) {
		switch (key) {
			case KeyCode.Numpad7: keysPressed._7 = true;
			case KeyCode.Numpad8: keysPressed._8 = true;
			case KeyCode.Numpad9: keysPressed._9 = true;
			case KeyCode.Numpad1: keysPressed._1 = true;
			case KeyCode.Numpad2: keysPressed._2 = true;
			case KeyCode.Numpad3: keysPressed._3 = true;
			default: 
		}
	}

	function OnKeyUp(key: KeyCode) {
		switch (key) {
			case KeyCode.Numpad7: keysPressed._7 = false;
			case KeyCode.Numpad8: keysPressed._8 = false;
			case KeyCode.Numpad9: keysPressed._9 = false;
			case KeyCode.Numpad1: keysPressed._1 = false;
			case KeyCode.Numpad2: keysPressed._2 = false;
			case KeyCode.Numpad3: keysPressed._3 = false;
			default: 
		}
		
	}

	function update(): Void {
		
		if (keysPressed._8) {
			playerVel.y -= playerSpeed.y;
		}
		if (keysPressed._7) {
			playerVel.x -= playerSpeed.x;
		}
		if (keysPressed._9) {
			playerVel.x += playerSpeed.x;
		}
		if (keysPressed._2) {
			playerVel.y += playerSpeed.y;
		}
		if (keysPressed._1) {
			playerVel.x -= playerSpeed.x;
		}
		if (keysPressed._3) {
			playerVel.x += playerSpeed.x;
		}

		Keyboard.get().show();

		playerPos.x += playerVel.x;
		playerPos.y += playerVel.y;
	}

	function render(framebuffer: Framebuffer): Void {
		var g2 = framebuffer.g2;

		g2.begin();

			g2.font = Assets.fonts.Kenney_Blocks;
			g2.fontSize = 20;
			g2.drawString("Teste", 20, 20);
			g2.drawRect(playerPos.x - playerSize.width/2, playerPos.y - playerSize.height/2, playerSize.width, playerSize.height, 2);
			g2.drawCircle(playerPos.x, playerPos.y, 10, 2);
		g2.end();
	}
}
