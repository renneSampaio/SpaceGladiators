package;

import kha.System;
import kha.Assets;

class Main {
	public static function main() {
		System.init({title: "Project", width: 600, height: 600}, function () {
			Assets.loadEverything( function() {
				new Project();
			});
		});
	}
}
