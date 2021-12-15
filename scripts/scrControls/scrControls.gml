function Action(button) constructor {
	self.button = button;
	
	static held = function() {
		return keyboard_check(self.button);
	}
	
	static pressed = function() {
		return keyboard_check_pressed(self.button);
	}
	
	static released = function() {
		return keyboard_check_released(self.button);
	}
}

global.left_action = new Action(vk_left);
global.right_action = new Action(vk_right);
global.up_action = new Action(vk_up);
global.down_action = new Action(vk_down);
global.jump_action = new Action(vk_shift);