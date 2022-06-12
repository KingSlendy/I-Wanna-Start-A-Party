with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	max_hspd = 0.5;
	enable_jump = false;
	enable_shoot = false;
	won = false;
	move_delay_timer = 0;
}

event_inherited();

action_end = function() {
	with (objMinigame4vs_Haunted_Boo) {
		image_index = 0;
		image_xscale = -5;
		alarm[0] = 0;
		alarm[1] = 0;
		alarm[2] = 0;
	}
}

player_check = objPlayerPlatformer;
state = 0;
