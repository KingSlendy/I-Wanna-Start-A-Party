event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		hp = 3;
		spd = 0;
		var players = [];
	
		with (objPlayerBase) {
			if (id == other.id) {
				continue;
			}
		
			array_push(players, id);
		}
	
		array_shuffle(players);
		chosed_player = players[0];
		chosed_offset = 0;
		delay_player = get_frames(10);
		delay_offset = get_frames(1);
		delay_shoot = 0;
		
		if (trial_is_title(TOUGH_IGNITION)) {
			hp = (network_id == global.player_id) ? 1 : 5;
		}
	}
}

minigame_camera = CameraMode.Center;
action_end = function() {
	with (objPlayerBase) {
		if (is_player_local(network_id)) {
			audio_stop_sound(audio_idle_looping);
		}
	}
}

player_type = objPlayerRocket;

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			if (--delay_player <= 0) {
				delay_player = get_frames(5);
				var record = infinity;
				
				with (objPlayerBase) {
					if (id == other.id || lost) {
						continue;	
					}
					
					var dist = point_distance(other.x, other.y, x, y);
					
					if (dist <= record) {
						other.chosed_player = id;
						record = dist;
					}
				}
			}
			
			if (--delay_offset <= 0) {
				delay_offset = get_frames(1);
				chosed_offset = irandom_range(-10, 10);
			}
			
			var angle = (image_angle + 360 + 90) % 360;
			var other_x = chosed_player.x;
			var other_y = chosed_player.y + lengthdir_y(chosed_player.sprite_height / 2, angle);
			
			var dir = (point_direction(x, y, other_x, other_y) + 360 + chosed_offset) % 360;
			var diff = angle_difference(angle, dir);
			
			if (abs(diff) > 6) {
				var action = (sign(diff) == 1) ? actions.right : actions.left;
				action.press();
			}
			
			if (abs(diff) < 90) {
				actions.up.press();
			} else {
				actions.down.press();
			}
			
			if (--delay_shoot <= 0) {
				actions.shoot.press();
				delay_shoot = get_frames(random_range(0.75, 1));
			}
		}
	}

	alarm_frames(11, 1);
});