event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_jump = false;
		enable_shoot = false;
		pos_offset = 0;
		pos_delay = 0;
		shoot_delay = 0;
	}
}

minigame_time = 50;
action_end = function() {
	if (minigame1vs3_solo().lost) {
		minigame4vs_points(minigame1vs3_solo().network_id);
	} else {
		for (var i = 0; i < minigame1vs3_team_length(); i++) {
			minigame4vs_points(minigame1vs3_team(i).network_id);
		}
	}
}

player_type = objPlayerPlatformer;

warp_start = false;
warp_delay = array_create(3, 0);

surf = noone;

part_system = part_system_create();
part_system_depth(part_system, layer_get_depth("Background") - 1);

part_type = part_type_create();
part_type_sprite(part_type, sprMinigame1vs3_Warping_Particle, false, false, false);
part_type_color_hsv(part_type, 0, 255, 127, 127, 255, 255);
part_type_alpha3(part_type, 0, 1, 0);
part_type_size(part_type, 0.5, 1, 0, 0);
part_type_speed(part_type, 0.5, 5, 0, 0); 
part_type_direction(part_type, 0, 359, 0, 0);
part_type_life(part_type, 200, 300);

part_emitter = part_emitter_create(part_system);
part_emitter_region(part_system, part_emitter, 0, 800, 0, 608, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(part_system, part_emitter, part_type, -40);

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
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
	
		with (player) {
			if (minigame1vs3_is_solo(i)) {
				var left_line = (collision_line(bbox_left - 3, bbox_top, bbox_left - 3, bbox_bottom + 96, objMinigame1vs3_Warping_Warp, true, true) != noone);
				var bbox_side = (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom + 96, objMinigame1vs3_Warping_Warp, true, true) != noone);
				var right_line = (collision_line(bbox_right + 3, bbox_top, bbox_right + 3, bbox_bottom + 96, objMinigame1vs3_Warping_Warp, true, true) != noone);
				
				if (x > 144 && left_line && !bbox_side && right_line) {
					break;
				}
				
				if (!left_line || x <= 144) {
					actions.left.press();
					break;
				}
				
				if (x > 144) {
					actions.right.hold(5);
				}
			} else {
				var solo_player = minigame1vs3_solo();
				
				if (--pos_delay <= 0) {
					pos_delay = get_frames(random_range(0.5, 1.5));
					pos_offset = choose(irandom_range(-96, -32), irandom_range(4, 8));
				}
				
				if (--shoot_delay <= 0) {
					actions.shoot.press();
					shoot_delay = get_frames(random_range(0.75, 1));
				}
				
				var beside_block = false;
				
				with (solo_player) {
					beside_block = place_meeting(x - 1, y, objMinigame1vs3_Warping_Push);
				}
				
				if (beside_block) {
					pos_offset = -96 + irandom_range(0, 32);
				}
				
				var dist = point_distance(x, y, solo_player.x + pos_offset, y)
				
				if (dist <= 3) {
					break;
				}
				
				var dir = point_direction(x, y, solo_player.x + pos_offset, y);
				
				if (dir == 0) {
					actions.right.hold(5);
				} else {
					actions.left.press();
				}
			}
		}
	}

	alarm_frames(11, 1);
});