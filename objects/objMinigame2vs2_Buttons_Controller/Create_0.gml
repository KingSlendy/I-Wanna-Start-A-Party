event_inherited();

minigame_start = minigame2vs2_start;
minigame_time = (!trial_is_title(CHALLENGE_MEDLEY)) ? 40 : 5;
minigame_time_end = function() {
	minigame2vs2_set_points(minigame2vs2_team(0, 0).network_id, minigame2vs2_team(0, 1).network_id, 0);
	minigame2vs2_set_points(minigame2vs2_team(1, 0).network_id, minigame2vs2_team(1, 1).network_id, 0);
	minigame_finish();
}

points_draw = (!trial_is_title(CHALLENGE_MEDLEY));
player_type = objPlayerPlatformer;
buttons_outside_list = [];
buttons_inside_list = [];

repeat (50) {
	array_push(buttons_outside_list, irandom(5));
	array_push(buttons_inside_list, irandom(5));
}

buttons_outside_current = 0;
buttons_inside_current = 0;

part_system = part_system_create();
part_system_depth(part_system, layer_get_depth("Background") - 1);

part_type = part_type_create();
part_type_sprite(part_type, sprMinigame2vs2_Buttons_Particle, false, false, false);
part_type_color_rgb(part_type, 0, 255, 0, 255, 0, 255);
part_type_alpha3(part_type, 0, 1, 0);
part_type_size(part_type, 0.5, 0.55, 0, 0);
part_type_speed(part_type, 3, 6, 0, 0); 
part_type_direction(part_type, 0, 359, 0, 0);
part_type_life(part_type, 50, 150);

part_emitter = part_emitter_create(part_system);
part_emitter_region(part_system, part_emitter, 0, 800, 0, 608, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(part_system, part_emitter, part_type, -2);

alarm_override(1, function() {
	alarm_inherited(1);
	alarm_instant(4);
	alarm_instant(5);
});

alarm_create(4, function() {
	var index = 0;

	with (objMinigame2vs2_Buttons_Button) {
		if (inside) {
			if (index == other.buttons_inside_list[other.buttons_inside_current]) {
				image_index = 1;
				other.buttons_inside_current++;
				
				//if (trial_is_title()) {
					
				//}
				break;
			}
		
			index++;
		}
	}

	//audio_play_sound(sndBlockChange, 0, false);
});

alarm_create(5, function() {
	var index = 0;

	with (objMinigame2vs2_Buttons_Button) {
		if (!inside) {
			if (index == other.buttons_outside_list[other.buttons_outside_current]) {
				image_index = 1;
				other.buttons_outside_current++;
				break;
			}
		
			index++;
		}
	}

	//audio_play_sound(sndBlockChange, 0, false);
});

alarm_override(11, function() {
	if (trial_is_title(CHALLENGE_MEDLEY)) {
		return;
	}
	
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);
		var player_info = player_info_by_id(i);
	
		with (objMinigame2vs2_Buttons_Button) {
			if (inside == (player_info.space == other.info.player_colors[0]) || image_index == 0) {
				instance_deactivate_object(id);
			}
		}
	
		if (!instance_exists(objMinigame2vs2_Buttons_Button)) {
			instance_activate_object(objMinigame2vs2_Buttons_Button);
			continue;
		}
	
		var near = instance_nearest(player.x, player.y, objMinigame2vs2_Buttons_Button);
		instance_activate_object(objMinigame2vs2_Buttons_Button);
		
		with (player) {
			var other_x = near.x + 20 * near.image_xscale;
			var other_y = near.y + sprite_yoffset;
		
			if (point_distance(x, y, other_x, other_y) > 224 && point_distance(x, y, other_x, other_y) > point_distance(teammate.x - 1, teammate.y - 7, other_x, other_y)) {
				break;
			}
		
			if (point_distance(x, y, other_x, other_y) <= 6) {
				actions.shoot.press();
				break;
			}
		
			mp_grid_path(other.grid, path, x, y, other_x, other_y, true);
			var dir = point_direction(x, y, path_get_point_x(path, 1), path_get_point_y(path, 1));
			
			if (abs(angle_difference(dir, 270)) >= 16) {
				var dist_to_up = abs(angle_difference(dir, 90));
				
				if (dist_to_up > 4) {
					var action = (dir >= 90 && dir <= 270) ? actions.left : actions.right;
					action.press();
				}
		
				if (--jump_delay_timer <= 0 && dist_to_up < 45) {
					actions.jump.hold(6);
					jump_delay_timer = 8;
				}
			}
		}
	}

	alarm_frames(11, 1);
});