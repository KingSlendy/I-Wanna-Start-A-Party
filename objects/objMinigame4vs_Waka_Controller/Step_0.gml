if (info.is_finished) {
	exit;
}

if (next_path == 0) {
	fade_alpha += 0.02 * DELTA;
	
	if (fade_alpha >= 1) {
		fade_alpha = 1;
		next_path = 1;
		
		switch (state_path) {
			case 0:
				with (objPlayerBase) {
					x = xstart;
					y = ystart;
					other.player_pos[network_id - 1] = player_info_by_id(network_id).turn - 1;
				}
			
				instance_destroy(objMinigame4vs_Waka_Intersect);
				var map_id = layer_tilemap_get_id("Lines");
			
				for (var c = 0; c < 13; c++) {
					for (var r = 0; r < 55; r++) {
						var tile_x = 192 + c * 32;
						var tile_y = 32 + r * 32;
						var tile = 7;
						
						if (c % 4 == 0) {
							tile = 28;
						}
						
						tilemap_set(map_id, tile, tilemap_get_cell_x_at_pixel(map_id, tile_x, tile_y), tilemap_get_cell_y_at_pixel(map_id, tile_x, tile_y));
					}
				}
			
				next_seed_inline();
				var choices = [208, 336, 464, 592];
				
				repeat (current_round++ + 1) {
					array_shuffle(choices);
					instance_create_layer(array_pop(choices), 48, "Actors", objMinigame4vs_Waka_PacMan);
				}
			
				for (var i = 0; i < 25; i++) {
					instance_create_layer(choose(224, 352, 480), 128 + 64 * i, "Actors", objMinigame4vs_Waka_Intersect);
				}
				
			case 1:
				camera_set_view_pos(view_camera[0], 0, 0);
				break;
		}
	}
} else if (next_path == 1) {
	fade_alpha -= 0.02 * DELTA;
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		next_path = -1;
		
		switch (state_path) {
			case 0:
				alarm_call(5, 0.1);
				break;
				
			case 1:
				with (objMinigame4vs_Waka_PacMan) {
					start_path();
				}
				
				camera_state = 1;
				break;
		}
	}
}

switch (camera_state) {
	case 0:
		camera_set_view_pos(view_camera[0], 0, camera_get_view_y(view_camera[0]) + 7);
	
		if (camera_get_view_y(view_camera[0]) >= 1216) {
			camera_set_view_pos(view_camera[0], 0, 1216);
			
			with (objPlayerBase) {
				guess_path = irandom(global.player_max - 1);
				frozen = false;
			}
			
			minigame_time = 4;
			alarm_call(10, 1);
			camera_state = -1;
		}
		break;
		
	case 1:
		var cam_h = camera_get_view_height(view_camera[0]);
		
		var far_pac = null;
		var record_y = -infinity;
		
		with (objMinigame4vs_Waka_PacMan) {
			if (y > record_y) {
				far_pac = id;
				record_y = y;
			}
		}
	
		var view_y = far_pac.y - floor(cam_h / 2);
		view_y = clamp(view_y, 0, room_height - cam_h);
		camera_set_view_pos(view_camera[0], 0, view_y);
		break;
}

with (objPlayerBase) {
	if (frozen) {
		continue;
	}
	
	var move = (global.actions.right.pressed(network_id) - global.actions.left.pressed(network_id));
	
	if (move != 0) {
		other.player_pos[network_id - 1] = (other.player_pos[network_id - 1] + global.player_max + move) % global.player_max;
		x = 192 + (32 * 4) * other.player_pos[network_id - 1] + 17;
	}
}