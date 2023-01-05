event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		image_xscale = 2;
		image_yscale = 2;
		touched = false;
		chosen_save = null;
		save_delay = 0;
	}
}

minigame_time = 40;
action_end = function() {
	alarm_stop(4);
}

points_draw = true;
player_type = objPlayerDir8;

created_green = 0;

trophy_saves = true;

alarm_override(1, function() {
	alarm_inherited(1);
	alarm_instant(4);
});

alarm_override(2, function() {
	alarm_inherited(2);
	
	if (array_contains(info.players_won, global.player_id) && trophy_saves && !trial_is_title(GREEN_DIVING)) {
		achieve_trophy(75);
	}
});

alarm_create(4, function() {
	if (instance_exists(objMinigame4vs_Sky_Save)) {
		objMinigame4vs_Sky_Save.front = true;
	}
	
	created_green = 0;
	var created_saves = [];
	
	for (var r = 0; r < 5; r++) {
		for (var c = 0; c < 5; c++) {
			array_push(created_saves, instance_create_layer(320 + 32 * c, 224 + 32 * r, "Actors", objMinigame4vs_Sky_Save));
		}
	}
	
	if (created_green == 0) {
		array_shuffle(created_saves);
			
		with (array_pop(created_saves)) {
			image_index = 1;
		}
	}
	
	objPlayerBase.touched = false;
	alarm_call(4, 2.2);
});

alarm_create(5, function() {
	instance_create_layer(irandom_range(200, 500), irandom_range(200, 408), "Actors", objMinigame4vs_Sky_Clouds);
	alarm_call(5, 0.05);
});

alarm_override(11, function() {
	if (trial_is_title(GREEN_DIVING)) {
		return;
	}
	
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			if (save_delay > 0) {
				save_delay--;
				break;
			}
			
			if (chosen_save == null) {
				var choices = [];
				var record = infinity;
				
				with (objMinigame4vs_Sky_Save) {
					if (image_index > 1) {
						continue;
					}
					
					array_push(choices, id);
				}
				
				array_shuffle(choices);
				chosen_save = array_pop(choices);
			} else {
				if (!instance_exists(chosen_save)) {
					save_delay = get_frames(random_range(0.2, 0.4));
					chosen_save = null;
					break;
				}
			}
			
			if (chosen_save == null || point_distance(x, y, chosen_save.xcenter, chosen_save.ycenter) <= 3) {
				break;
			}
			
			var dir = point_direction(x, y, chosen_save.xcenter, chosen_save.ycenter);
			minigame_angle_dir8(actions, dir);
		}
	}

	alarm_next(11);
});

alarm_next(5);