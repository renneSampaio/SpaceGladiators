package;

import kha.Framebuffer;
import kha.Assets;
import kha.Scheduler;
import kha.System;
import kha.input.Keyboard;
import kha.input.KeyCode;
import kha.math.FastMatrix3;
import kha.math.FastVector2;

using kha.graphics2.GraphicsExtension;

class Project {
	
	var playerPos = {x: System.windowWidth(0)/2, y: System.windowHeight(0)/2};
	var playerSize = {width: 20, height: 30};
	var keysPressed = {_7: false, _8: false, _9: false, _1: false, _2: false, _3: false}
	var playerVel = {x: 0., y: 0.};
	var playerSpeed = {x: 5./60, y: 5./60};
	var playerAngle = 0.;
	var playerTranslation: FastMatrix3;
	var playerRotation: FastMatrix3;

	var bulletPos : Array<FastVector2>;
	var bulletVel : Array<FastVector2>;
	var bulletIndex = 0;

	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		
		if (Keyboard.get() != null) Keyboard.get().notify(OnKeyDown, OnKeyUp);

		bulletPos = new Array<FastVector2>();
		bulletVel = new Array<FastVector2>();
	}

	public function Restart() {
		playerPos = {x: System.windowWidth(0)/2, y: System.windowHeight(0)/2};
		playerVel = {x: 0., y: 0.};
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
			case KeyCode.Numpad5: FireBullet();
			case KeyCode.R		: Restart();
			default: 
		}
		
	}

	function FireBullet() 
	{
		bulletPos[bulletIndex] = new FastVector2(playerPos.x, playerPos.y);
		bulletVel[bulletIndex] = FastMatrix3.rotation(playerAngle).multvec(new FastVector2(0, -playerSpeed.y * 100));

		playerVel.x -= bulletVel[bulletIndex].x/80;
		playerVel.y -= bulletVel[bulletIndex].y/80;
		
		bulletIndex++;
		if (bulletIndex == 30) bulletIndex = 0;
	}

	function update(): Void {
		
		if (keysPressed._8) {
			
			var deltaVel = FastMatrix3.rotation(playerAngle).multvec(new FastVector2(0, playerSpeed.y));

			playerVel.x += deltaVel.x;
			playerVel.y += deltaVel.y;
		}
		if (keysPressed._7) {
			//playerVel.x -= playerSpeed.x;
			playerAngle += 5/System.refreshRate;
		}
		if (keysPressed._9) {
			//playerVel.x += playerSpeed.x;
			playerAngle -= 5/System.refreshRate;
		}
		if (keysPressed._2) {
			var deltaVel = FastMatrix3.rotation(playerAngle).multvec(new FastVector2(0, -playerSpeed.y));

			playerVel.x += deltaVel.x;
			playerVel.y += deltaVel.y;
		}
		if (keysPressed._1) {
			//playerVel.x -= playerSpeed.x;
		}
		if (keysPressed._3) {
			//playerVel.x += playerSpeed.x;
		}

		Keyboard.get().show();

		playerPos.x += playerVel.x;
		playerPos.y += playerVel.y;

		for (i in 0...bulletPos.length) {
			bulletPos[i] = bulletPos[i].add(bulletVel[i]);
		}
	}

	function render(framebuffer: Framebuffer): Void {
		var g2 = framebuffer.g2;

		g2.begin();

			g2.font = Assets.fonts.Kenney_Blocks;
			g2.fontSize = 20;
			g2.drawString("player.x: " + playerPos.x, 20, 20);
			g2.drawString("player.y: " + playerPos.y, 20, 35);


			playerTranslation = FastMatrix3.translation(playerPos.x, playerPos.y);
			playerRotation = FastMatrix3.rotation(playerAngle);

			var transformation = playerTranslation.multmat(playerRotation);

			g2.pushTransformation(transformation);
				if (keysPressed._8) {			
					g2.drawRect(-2.5, -playerSize.height+5, 5, 5, 4);
				}
				if (keysPressed._7) {
					g2.drawRect(-playerSize.width, -playerSize.height/2, 5, 5, 4);
					g2.drawRect(playerSize.width-5, playerSize.height/2, 5, 5, 4);
				}
				if (keysPressed._9) {
					g2.drawRect(playerSize.width-5, -playerSize.height/2, 5, 5, 4);
					g2.drawRect(-playerSize.width, playerSize.height/2, 5, 5, 4);
				}
				if (keysPressed._2) {
					g2.drawRect(-2.5, playerSize.height/2 +5*2, 5, 5, 4);
				}

				g2.drawRect( -playerSize.width/2, -playerSize.height/2, playerSize.width, playerSize.height, 2);
				g2.drawRect( -2.5, -playerSize.height/2, 5, 10);
				g2.drawCircle(0, playerSize.height/2, 10, 2);				
			g2.popTransformation();


			for (b in bulletPos) {
				transformation = FastMatrix3.translation(b.x, b.y);
				g2.pushTransformation(transformation);
					g2.drawCircle(0, 0, 3, 1);
				g2.popTransformation();
			}
		g2.end();
	}
}
