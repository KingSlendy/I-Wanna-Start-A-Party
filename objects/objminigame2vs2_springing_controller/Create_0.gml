with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_shoot = false;
}

event_inherited();

minigame_start = minigame2vs2_start;
action_end = function() {
	objMinigame2vs2_Springing_Spring.enabled = false;
	
	with (objMinigame2vs2_Springing_Piranha) {
		image_index = 0;
		alarm[0] = 0;
	}
	
	instance_destroy(objMinigame2vs2_Springing_Fireball);
}

player_check = objPlayerPlatformer;