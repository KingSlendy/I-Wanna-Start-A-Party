if (global.player_id != 1) {
	exit;
}

for (var i = 2; i <= global.player_max; i++) {
	var actions = check_player_actions_by_id(i);

	if (actions == null) {
		continue;
	}
		
	var player = focus_player_by_id(i);
	var player_info = player_info_by_id(i);
	
	with (objMinigame1vs3_Buttons_Button) {
		if (inside == (player_info.space == other.info.player_colors[0]) || image_index == 0) {
			instance_deactivate_object(id);
		}
	}
	
	if (!instance_exists(objMinigame1vs3_Buttons_Button)) {
		instance_activate_object(objMinigame1vs3_Buttons_Button);
		continue;
	}
	
	var near = instance_nearest(player.x, player.y, objMinigame1vs3_Buttons_Button);
	instance_activate_object(objMinigame1vs3_Buttons_Button);
	var dir = null;
		
	with (player) {
		var me_x = x - 1;
		var me_y = y - 7;
		var other_x = near.x + 20 * near.image_xscale;
		var other_y = near.y;
		
		if (point_distance(me_x, me_y, other_x, other_y) <= 3) {
			actions.shoot.press();
			break;
		}
		
		mp_grid_path(other.grid, path, me_x, me_y, other_x, other_y, false);
		dir = point_direction(me_x, me_y, path_get_point_x(path, 1), path_get_point_y(path, 1));
			
		if (point_distance(0, dir, 0, 270) >= 16) {
			var dist_to_up = point_distance(0, dir, 0, 90);
				
			if (dist_to_up > 4) {
				var action = (dir >= 90 && dir <= 270) ? actions.left : actions.right;
				action.press();
			}
		
			if (--jump_delay_timer <= 0 && dist_to_up < 16 && vspeed >= 0) {
				actions.jump.hold(6);
				jump_delay_timer = 10;
			}
		}
	}
}

alarm[11] = 1;
