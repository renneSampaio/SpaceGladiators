package;

import kha.input.Keyboard;
import kha.input.KeyCode;

class SGInputManager {
	private static var instance: SGInputManager = null;

	private var downObservers: Map<KeyCode, Array<Void->Void>>;
	private var upObservers: Map<KeyCode, Array<Void->Void>>;

	private function new() {
		Keyboard.get().notify(OnKeyDown, OnKeyUp, OnKeyPress);

		downObservers = new Map<KeyCode, Array<Void->Void>>();
		upObservers = new Map<KeyCode, Array<Void->Void>>();
	}

	public static function Get(): SGInputManager {
		if (instance == null)
			instance = new SGInputManager();
		return instance;
	}

	function OnKeyDown(key: KeyCode) {
		var observers = downObservers.get(key);

		if (observers == null) return;

		for (func in observers)
			func();
	}

	function OnKeyUp(key: KeyCode) {
		var observers = upObservers.get(key);

		if (observers == null) return;

		for (func in observers)
			func();
	}

	function OnKeyPress(key: String) {		
	}

	public function AddDownObserver(key: KeyCode, func: Void->Void) {
		var observers = downObservers.get(key);
		if (observers == null) {
			var funcs = new Array<Void->Void>();
			funcs.push(func);
			downObservers.set(key, funcs);
		} else {
			observers.push(func);
		}
	}

	public function AddUpObserver(key: KeyCode, func: Void->Void) {
		var observers = upObservers.get(key);
		if (observers == null) {
			var funcs = new Array<Void->Void>();
			funcs.push(func);
			upObservers.set(key, funcs);
		} else {
			observers.push(func);
		}
	}

	public function AddUpDownObserver(key: KeyCode, down: Void->Void, up: Void->Void) {
		AddDownObserver(key, down);
		AddUpObserver(key, up);
	}
}