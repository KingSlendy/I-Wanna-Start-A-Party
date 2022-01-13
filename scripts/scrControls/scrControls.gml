function Action(button) constructor {
	self.button = button;
	self.label = "";
	
	static held = function(id = null) {
		if (id != null && id > 0 && id != global.player_id) {
			return ai_actions(id)[$ self.label].pressed();
		}
		
		return keyboard_check(self.button);
	}
	
	static pressed = function(id = null) {
		if (id != null && id > 0 && id != global.player_id) {
			return self.held(id);
		}
		
		return keyboard_check_pressed(self.button);
	}
	
	static released = function() {
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
	self.frames = 0;
	
	static hold = function(frames) {
		self.frames = frames;
		self.triggered = true;
	}
	
	static press = function() {
		self.triggered = true;
	}
	
	static release = function() {
		if (self.frames > 0) {
			self.frames--;
			return;
		}
		
		self.triggered = false;
	}	
	
	static pressed = function() {
		return self.triggered;
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