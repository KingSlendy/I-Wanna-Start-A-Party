event_inherited();

minigame_start = minigame2vs2_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_shoot = false;
		grav_amount = 0;
	}
}

action_end = function() {
	objMinigame2vs2_Springing_Spring.enabled = false;
	
	with (objMinigame2vs2_Springing_Piranha) {
		image_index = 0;
		alarm_stop(0);
	}
	
	instance_destroy(objMinigame2vs2_Springing_Fireball);
}

player_type = objPlayerPlatformer;

alarm_override(1, function() {
	alarm_inherited(1);
	objMinigame2vs2_Springing_Spring.enabled = true;

	with (objMinigame2vs2_Springing_Piranha) {
		image_index = 1;
		alarm_frames(0, 1);
	}

	objPlayerBase.grav_amount = 0.4;
});

alarm_override(11, function() {
	if (global.player_id != 1) {
		return;
	}

	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var keys = variable_struct_get_names(actions);
		var action = choose(actions.left, actions.right);
		//action.press();
	}

	alarm_frames(11, 1);
});