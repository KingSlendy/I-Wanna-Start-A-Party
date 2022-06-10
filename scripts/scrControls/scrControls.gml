function Action(button) constructor {
	self.button = button;
	self.label = "";
	
	static held = function(id = null) {
		if (id != null && id > 0 && id != global.player_id) {
			return ai_actions(id)[$ self.label].held(id);
		}
		
		return keyboard_check(self.button);
	}
	
	static pressed = function(id = null) {
		if (id != null && id > 0 && id != global.player_id) {
			return ai_actions(id)[$ self.label].pressed(id);
		}
		
		return keyboard_check_pressed(self.button);
	}
	
	static released = function(id = null) {
		if (id != null && id > 0 && id != global.player_id) {
			return ai_actions(id)[$ self.label].released(id);
		}
		
		return keyboard_check_released(self.button);
	}
}

global.actions = {
	left: new Action(vk_left),
	right: new Action(vk_right),
	up: new Action(vk_up),
	down: new Action(vk_down),
	jump: new Action(vk_shift),
	shoot: new Action(ord("Z"))
};

var keys = variable_struct_get_names(global.actions);

for (var i = 0; i < array_length(keys); i++) {
	var key = keys[i];
	global.actions[$ key].label = key;
}

function AIAction() constructor {
	self.triggered = false;
	self.untriggered = false;
	self.frames = 0;
	
	static hold = function(frames) {
		self.frames = frames;
		self.triggered = true;
		self.untriggered = false;
	}
	
	static press = function() {
		self.triggered = true;
		self.untriggered = false;
	}
	
	static release = function(force = false) {
		var prev_untriggered = self.untriggered;
		self.untriggered = false;
		
		if (self.frames > 0 && !force) {
			self.frames--;
			return;
		}
		
		self.triggered = false;
		self.untriggered = !prev_untriggered;
	}
	
	static held = function() {
		return self.triggered;
	}
	
	static pressed = function() {
		return self.held();
	}
	
	static released = function() {
		return self.untriggered;
	}
}

global.all_ai_actions = [];

repeat (3) {
	var actions = {};
	var keys = variable_struct_get_names(global.actions);
	
	for (var i = 0; i < array_length(keys); i++) {
		actions[$ keys[i]] = new AIAction();
	}
	
	array_push(global.all_ai_actions, actions);
}

function ai_actions(id) {
	return global.all_ai_actions[id - 1];
}

function ai_release_all() {
	for (var i = 1; i <= array_length(global.all_ai_actions); i++) {
		var actions = ai_actions(i);
		
		if (actions != null) {
			var keys = variable_struct_get_names(actions);
	
			for (var j = 0; j < array_length(keys); j++) {
				actions[$ keys[j]].release();
			}
		}
	}
}

function check_player_actions_by_id(player_id) {
	var actions = ai_actions(player_id);

	if (actions == null) {
		return null;
	}

	if (!is_player_local(player_id)) {
		return null;
	}
	
	return actions;
}

function bind_to_key(bind) {
	switch (bind) {
		//Alphanumeric keys
		case ord("0"): return 0;
		case ord("1"): return 1;
		case ord("2"): return 2;
		case ord("3"): return 3;
		case ord("4"): return 4;
		case ord("5"): return 5;
		case ord("6"): return 6;
		case ord("7"): return 7;
		case ord("8"): return 8;
		case ord("9"): return 9;
		case ord("A"): return 10;
		case ord("B"): return 17;
		case ord("C"): return 25;
		
	    //Special keys
	    case vk_space: return 77;
	    case vk_shift: case vk_lshift: case vk_rshift: return sprKey_Shift;
	    case vk_control: case vk_lcontrol: case vk_rcontrol: return 27;
	    case vk_alt: case vk_lalt: case vk_ralt: return 11;
	    case vk_enter: return 34;
	    case vk_up: return sprKey_ArrowUp;
	    case vk_down: return sprKey_ArrowDown;
	    case vk_left: return sprKey_ArrowLeft;
	    case vk_right: return sprKey_ArrowRight;
	    case vk_backspace: return 19;
	    case vk_tab: return 79;
	    case vk_insert: return "Insert";
	    case vk_delete: return "Delete";
	    case vk_pageup: return "Page Up";
	    case vk_pagedown: return "Page Down";
	    case vk_home: return "Home";
	    case vk_end: return "End";
	    case vk_escape: return "Escape";
	    case vk_printscreen: return "Print Screen";
	    case vk_f1: return 37;
	    case vk_f2: return 38;
	    case vk_f3: return 39;
	    case vk_f4: return 40;
	    case vk_f5: return 41;
	    case vk_f6: return 42;
	    case vk_f7: return 43;
	    case vk_f8: return 44;
	    case vk_f9: return 45;
	    case vk_f10: return 46;
	    case vk_f11: return 47;
	    case vk_f12: return 48;
    
	    //Numpad keys
	    case 96: return "0";
	    case 97: return "1";
	    case 98: return "2";
	    case 99: return "3";
	    case 100: return "4";
	    case 101: return "5";
	    case 102: return "6";
	    case 103: return "7";
	    case 104: return "8";
	    case 105: return "9";
	    case 106: return "*";
	    case 107: return "+";
	    case 109: return "-";
	    case 110: return ".";
	    case 111: return "/";
    
	    //Misc. keys
	    case 186: return ";";
	    case 187: return "=";
	    case 188: return ",";
	    case 189: return "-";
	    case 190: return ".";
	    case 191: return "/";
	    case 192: return "`";
	    case 219: return "[";
	    case 220: return "\\";
	    case 221: return "]";
	    case 222: return "'";
    
	    //Other characters
	    default: return chr(bind);
	}
}
