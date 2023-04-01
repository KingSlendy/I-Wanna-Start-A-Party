event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		goal_num = 0;
		last_num = 0;
		fast_collide = false;
	}
}

points_draw = true;
player_type = objPlayerBubble;

lap_total = 3;
goal_total = instance_number(objMinigame4vs_Bubble_Goal);
priority = ds_priority_create();
places = ds_map_create();

trophy_hitless = true;

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			var goal = null;
			
			with (objMinigame4vs_Bubble_Goal) {
				if (num == (other.goal_num + 1) % 4) {
					goal = id;
					break;
				}
			}
			
			var cell_x = floor(x / other.grid_size);
			var cell_y = floor(y / other.grid_size);
			var other_x = goal.x + goal.sprite_width / 2;
			var other_y = goal.y + goal.sprite_height / 2;
			mp_grid_path((image_alpha == 1) ? other.grid : other.grid_spikeless, path, x, y, other_x, other_y, true);
			
			var dir = point_direction(path_get_point_x(path, 0), path_get_point_y(path, 0), path_get_point_x(path, 1) + random_range(-4, 4), path_get_point_y(path, 1) + random_range(-4, 4));
			var spd = point_distance(0, 0, hspd, vspd);
			var angle = dir;
			
			if (!fast_collide && spd > 3 && image_alpha == 1 && !place_meeting(x, y, objMinigame4vs_Bubble_Spike)) {
				var times = 6;
				var time = 0;
				var hspd_collide = hspd;
				var vspd_collide = vspd;
			
				while (time++ < times) {
					if (place_meeting(x + hspd_collide, y + vspd_collide, objMinigame4vs_Bubble_Spike)) {
						fast_collide = true;
						break;
					}
					
					hspd_collide += hspd_collide + 0.1 * sign(hspd);
					vspd_collide += vspd_collide + 0.1 * sign(vspd);
				}
			}
			
			if (fast_collide) {
				if (spd >= 0.75) {
					angle = point_direction(hspd, vspd, 0, 0);
				} else {
					fast_collide = false;
				}
			}
			
			if (!fast_collide && spd > 5) {
				break;
			}
			
			minigame_angle_dir8(actions, angle);
		}
	}

	alarm_frames(11, 1);
});