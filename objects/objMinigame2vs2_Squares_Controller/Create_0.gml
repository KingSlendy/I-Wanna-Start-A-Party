event_inherited();

minigame_start = minigame2vs2_start;
minigame_time = 40;
action_end = function() {
	alarm_stop(4);
	alarm_stop(5);
	
	var player = focus_player_by_id(global.player_id);
	
	if (minigame2vs2_get_points(player.network_id, player.teammate.network_id) >= 22) {
		achieve_trophy(29);
	}
}

points_draw = true;
player_type = objPlayerStatic;

half_count = 6;
half_width = 32 * half_count;

function create_halfs() {
	next_seed_inline();
	var sprites = [null, null];
	var rows = array_create(half_count, 0);
	
	for (var i = 0; i < half_count; i++) {
		rows[i] = irandom_range(1, half_count - 1);
	}
	
	var indexes = array_sequence(0, sprite_get_number(sprMinigame2vs2_Squares_Square));
	array_shuffle_ext(indexes);
	array_delete(indexes, 2, array_length(indexes) - 2);
	
	for (var i = 0; i < 2; i++) {
		var surf = surface_create(half_width, half_width);
		surface_set_target(surf);
		draw_clear_alpha(c_black, 0);
	
		for (var j = 0; j < half_count; j++) {
			var row = (i == 0) ? rows[j] : half_count - rows[j];
			
			for (var k = 0; k < row; k++) {
				if (i == 0) {
					var draw_x = half_width - 32 * (k + 1);
				} else {
					var draw_x = 32 * k;
				}
				
				var draw_y = 32 * j;
				draw_sprite_ext(sprMinigame2vs2_Squares_Square, indexes[i], draw_x, draw_y, 1, 1, 0, c_white, 1);
			}
		}
	
		surface_reset_target();
		sprites[i] = sprite_create_from_surface(surf, 0, 0, half_width, half_width, false, false, half_width / 2, half_width / 2);
		surface_free(surf);
	}
	
	return sprites;
}

function spawn_halfs(left) {
	var spawn_x = (left) ? 168 : 568;
	var sprites = create_halfs();
	var h1 = instance_create_layer(spawn_x, -100, "Actors", objMinigame2vs2_Squares_Halfs);
	h1.sprite_index = sprites[0];
	h1.image_angle = choose(irandom_range(0, 45), irandom_range(135, 359));
	h1.network_id = points_teams[!left][0].network_id;
	h1.color = info.player_colors[!left];
	h1.top = true;
	h1.target_y = 160;
	var h2 = instance_create_layer(spawn_x, 708, "Actors", objMinigame2vs2_Squares_Halfs);
	h2.sprite_index = sprites[1];
	h2.image_angle = choose(irandom_range(0, 45), irandom_range(135, 359));
	h2.network_id = points_teams[!left][1].network_id;
	h2.color = info.player_colors[!left];
	h2.target_y = 448;
}

alarm_override(0, function() {
	alarm_inherited(0);
	alarm_call(4, 0.5);
	alarm_call(5, 0.5);
});

alarm_create(4, function() {
	spawn_halfs(true);
});

alarm_create(5, function() {
	spawn_halfs(false);
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		with (objMinigame2vs2_Squares_Halfs) {
			if (network_id != i) {
				continue;
			}
		
			var angle_diff = angle_difference(image_angle, 90);
		
			if (abs(angle_diff) <= 6) {
				continue;
			}

			var action = (sign(angle_diff) == 1) ? actions.right : actions.left;
			action.hold(irandom_range(1, 10));
		}
	}

	alarm_frames(11, 8);
});