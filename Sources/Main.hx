package;

import kha.System;

class Main {
	public static function main() {
		System.init({title: "Project", width: 600, height: 600}, function () {
			new Project();
		});
	}
}
