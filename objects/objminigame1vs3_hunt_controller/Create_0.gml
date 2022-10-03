event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_shoot = false;
		shoot_delay = 0;
		reticle = null;
		solo_x = 0;
		solo_y = 0;
		offset_len = 0;
		offset_dir = 0;
		aim_delay = 0;
	}
}

minigame_time = 20;
minigame_time_end = function() {
	if (!minigame1vs3_solo().lost) {
		minigame4vs_points(minigame1vs3_solo().network_id);
		
		if (minigame1vs3_solo().network_id == global.player_id && trophy_jump) {
			achieve_trophy(53);
		}
	} else {
		minigame1vs3_points();
	}
	
	minigame_finish();
}

player_type = objPlayerPlatformer;
shoot_start = false;
shoot_delay = array_create(3, 0);
trophy_jump = true;

function create_shoot(x, y) {
	instance_create_layer(x, y, "Actors", objMinigame1vs3_Hunt_Shot);
}

alarm_override(1, function() {
	with (objPlayerBase) {
		if (y < 640) {
			frozen = false;
			break;
		}
	}

	shoot_start = true;
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			if (minigame1vs3_is_solo(i)) {
				
			} else {
				if (reticle == null) {
					break;
				}
				
				var solo_player = minigame1vs3_solo();
				
				if (--aim_delay <= 0) {
					offset_len = irandom(32);
					offset_dir = irandom(359)
					solo_x = solo_player.x + hspd * 3 + lengthdir_x(offset_len, offset_dir);
					solo_y = solo_player.y + vspd * 3 + lengthdir_y(offset_len, offset_dir);
					aim_delay = get_frames(random_range(0.05, 0.1));
				}
				
				if (--shoot_delay <= 0) {
					actions.shoot.press();
					shoot_delay = get_frames(random_range(0.9, 1.2));
				}
				
				var dist = point_distance(reticle.x, reticle.y, solo_x, solo_y);
				
				if (dist <= 3) {
					break;
				}
				
				var dir = point_direction(reticle.x, reticle.y, solo_x, solo_y);
				minigame_angle_dir8(actions, round(dir / 45) % 8);
			}
		}
	}

	alarm_frames(11, 1);
});