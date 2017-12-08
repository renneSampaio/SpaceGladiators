package;

import kha.System;
import kha.Assets;

class Main {
	public static function main() {
		System.init({title: "Space Gladiators"}, function () {
			Assets.loadEverything( function() {
				new Project();
			});
		});
	}
}
