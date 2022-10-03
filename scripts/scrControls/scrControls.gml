global.ignore_input = false;

input_axis_threshold_set(gp_axislh, 0.5, 1);
input_axis_threshold_set(gp_axislv, 0.5, 1);

function Action() constructor {
	static held = function(id = 0) {
		if (global.ignore_input) {
			return false;
		}
		
		if (id > 0 && id != global.player_id) {
			return ai_actions(id)[$ self.verb].held(id);
		}
		
		return input_check(self.verb);
	}
	
	static pressed = function(id = 0) {
		if (global.ignore_input) {
			return false;
		}
		
		if (id > 0 && id != global.player_id) {
			return ai_actions(id)[$ self.verb].pressed(id);
		}
		
		return input_check_pressed(self.verb);
	}
	
	static released = function(id = 0) {
		if (global.ignore_input) {
			return false;
		}
		
		if (id > 0 && id != global.player_id) {
			return ai_actions(id)[$ self.verb].released(id);
		}
		
		return input_check_released(self.verb);
	}
	
	static consume = function() {
		try {
			for (var i = 2; i <= global.player_max; i++) {
				var actions = check_player_actions_by_id(i);
			
				if (actions == null) {
					continue;
				}
			
				actions[$ self.verb].release(true);
			}
		} catch (_) {}
		
		input_consume(self.verb);
	}
	
	static bind = function() {
		return bind_to_icon(input_binding_get(self.verb,,, input_profile_get() ?? "keyboard_and_mouse").value);
	}
}

global.actions = {
	left: new Action(),
	right: new Action(),
	up: new Action(),
	down: new Action(),
	jump: new Action(),
	shoot: new Action(),
	pause: new Action()
};

var keys = variable_struct_get_names(global.actions);

for (var i = 0; i < array_length(keys); i++) {
	var key = keys[i];
	global.actions[$ key].verb = key;
}

function AIAction() constructor {
	self.triggered = false;
	self.untriggered = false;
	self.just_triggered = false;
	self.frames = 0;
	
	static hold = function(frames) {
		self.frames = frames;
		self.triggered = true;
		self.untriggered = false;
		self.just_triggered = true;
	}
	
	static press = function() {
		self.triggered = true;
		self.untriggered = false;
		self.just_triggered = true;
	}
	
	static release = function(force = false) {
		var prev_untriggered = self.untriggered;
		self.untriggered = false;
		self.just_triggered = false;
		
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
		return self.triggered && self.just_triggered;
	}
	
	static released = function() {
		return self.untriggered;
	}
}

global.all_ai_actions = [];

repeat (3) {
	var actions = {};
	
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
	var player = focus_player_by_id(player_id);
	var actions = ai_actions(player_id);

	if (actions == null || !is_player_local(player.network_id) || !player.ai) {
		return null;
	}
	
	return actions;
}

function bind_to_icon(bind) {
	//Alphanumeric keys
	if (bind >= 48 && bind <= 57 || bind >= 65 && bind <= 90 || bind >= 96 && bind <= 105) {
		return asset_get_index("sprKey_" + chr(bind));
	}
	
	var binds = {};
	
	//Keyboard
	binds[$ vk_left] = sprKey_ArrowLeft;
	binds[$ vk_right] = sprKey_ArrowRight;
	binds[$ vk_up] = sprKey_ArrowUp;
	binds[$ vk_down] = sprKey_ArrowDown;
	binds[$ vk_shift] = sprKey_Shift;
	binds[$ vk_lshift] = sprKey_Shift;
	binds[$ vk_rshift] = sprKey_Shift;
	binds[$ vk_enter] = sprKey_Enter;
	binds[$ vk_backspace] = sprKey_Backspace;
	binds[$ vk_escape] = sprKey_Escape;
	
	//Gamepad
	binds[$ gp_axislh] = sprButton_StickLeft;
	binds[$ gp_axislv] = sprButton_StickLeft;
	binds[$ gp_axisrh] = sprButton_StickRight;
	binds[$ gp_axisrv] = sprButton_StickRight;
	binds[$ gp_face1] = sprButton_A;
	binds[$ gp_face2] = sprButton_B;
	binds[$ gp_face3] = sprButton_Y;
	binds[$ gp_face4] = sprButton_X;
	binds[$ gp_padl] = sprButton_PadLeft;
	binds[$ gp_padr] = sprButton_PadRight;
	binds[$ gp_padu] = sprButton_PadUp;
	binds[$ gp_padd] = sprButton_PadDown;
	binds[$ gp_shoulderlb] = sprButton_TriggerLeft;
	binds[$ gp_shoulderrb] = sprButton_TriggerRight;
	binds[$ gp_shoulderl] = sprButton_BumperLeft;
	binds[$ gp_shoulderr] = sprButton_BumperRight;
	binds[$ gp_select] = sprButton_Back;
	binds[$ gp_start] = sprButton_Start;
	
	if (!variable_struct_exists(binds, bind)) {
		return sprKey_Blank;
	}
	
	return binds[$ bind];
	
	switch (bind) {
	    //Special keys
	    case vk_space: return 77;
	    case vk_control: case vk_lcontrol: case vk_rcontrol: return 27;
	    case vk_alt: case vk_lalt: case vk_ralt: return 11;
	    case vk_enter: return 34;
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