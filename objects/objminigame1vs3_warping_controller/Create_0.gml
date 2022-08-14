with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_jump = false;
	enable_shoot = false;
}

event_inherited();

minigame_start = minigame1vs3_start;
minigame_time = 50;
action_end = function() {
	if (points_teams[1][0].lost) {
		minigame4vs_points(points_teams[1][0].network_id);
	} else {
		for (var i = 0; i < array_length(points_teams[0]); i++) {
			minigame4vs_points(points_teams[0][i].network_id);
		}
	}
}

player_check = objPlayerPlatformer;

warp_start = false;
warp_delay = array_create(3, 0);

function create_warp(x, y) {
	instance_create_layer(x, y, "Actors", objMinigame1vs3_Warping_Warp, {
		vspeed: -8
	});
}

alarm_override(1, function() {
	alarm_inherited(1);
	warp_start = true;
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
	
		var player = focus_player_by_id(i);
	
		with (player) {
			if (y < 304) { 
				actions.left.press();
			} else {
				var keys = variable_struct_get_names(actions);
				var action = actions[$ keys[irandom(array_length(keys) - 1)]];
		
				switch (irandom(2)) {
					case 0:
						action.hold(irandom(21));
						break;
				
					case 1:
						action.press();
						break;
				
					case 2:
						action.release(true);
						break;
				}
			}
		}
	}

	alarm_frames(11, 1);
});