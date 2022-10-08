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
		offset_delay = 0;
	}
	
	objBlock.touched = false;
}

minigame_time = 20;
minigame_time_end = function() {
	if (!minigame1vs3_solo().lost) {
		minigame4vs_points(minigame1vs3_solo().network_id);
	} else {
		minigame1vs3_points();
	}
	
	minigame_finish();
}

player_type = objPlayerPlatformer;
shoot_start = false;
shoot_delay = array_create(3, 0);

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
					solo_x = solo_player.x;
					solo_y = solo_player.y;
					
					if (point_distance(0, 0, solo_player.hspd, solo_player.vspd) != 0) {
						solo_x += solo_player.hspd * 5 + lengthdir_x(offset_len, offset_dir);
						solo_y += solo_player.vspd * 5 + lengthdir_y(offset_len, offset_dir);
					}
					
					aim_delay = get_frames(random_range(0.05, 0.1));
				}
				
				if (--offset_delay <= 0) {
					offset_len = irandom_range(32, 128);
					offset_dir = irandom(359);
					offset_delay = get_frames(random_range(2, 3));
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
				minigame_angle_dir8(actions, dir);
			}
		}
	}

	alarm_frames(11, 1);
});