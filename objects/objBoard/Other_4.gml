if (!IS_BOARD) {
	exit;
}

if (!global.board_started) {
	with (objPlayerBase) {
		change_to_object(objPlayerBoard);
	}
	
	if (HAS_SAVED) { //Load board
		global.board_started = true;
		load_board();
		calculate_player_place();
		global.player_game_ids = [];
		prev_board_light = !global.board_light;
	} else { //Initialize board
		global.game_key = date_datetime_string(date_current_datetime()) + " " + string(get_timer()) + " " + string(irandom(9999999));
		shuffle_seed_bag();
		next_seed_inline();
		global.initial_rolls = array_sequence(1, 10);
		array_shuffle_ext(global.initial_rolls);
		array_delete(global.initial_rolls, global.player_max, array_length(global.initial_rolls) - global.player_max);
		
		for (var i = 1; i <= global.player_max; i++) {
			var player = focus_player_by_id(i);
			
			with (objPlayerReference) {
				if (reference == 0) {
					player.x = x + 17 + 32 * (i - 1);
					player.y = y + 23;
					break;
				}
			}
		}
	}
}
	
var target_follow = null;

with (objPlayerReference) {
	if (reference == 1) {
		target_follow = id;
		break;
	}
}

camera_start_follow(target_follow, objCameraBoard);

if (global.minigame_info.is_finished) {
	instance_create_layer(0, 0, "Managers", objResultsMinigame);
}

switch (room) {
	case rBoardIsland:
		global.board_day = ((global.board_turn - 1) % 6 < 3);
	
		if (!global.board_day) {
			layer_set_visible("Night", true);
			layer_set_visible("Misc_Day", false);
			layer_set_visible("Misc_Night", true);
		}
		break;
	
	case rBoardHotland: case rBoardPallet: global.shine_spawn_count = 2; break;
	
	case rBoardBaba:
		reset_seed_inline();
	
		for (var i = 0; i < array_length(global.baba_blocks); i++) {
			next_seed_inline();
			global.baba_blocks[i] = irandom(array_length(global.baba_blocks) - 1);
			
			with (objBoardBabaBlock) {
				if (block_id == i) {
					block_update();
					break;
				}
			}
		}
		
		var price = 5;
		
		if (global.baba_toggled[2]) {
			switch (global.baba_blocks[2]) {
				case 0: price *= 2; break;
				case 1: price /= 2; break;
				case 2: price = 0; break;
			}
			
			price = floor(price);
		}
		
		global.min_shop_coins = price;
		break;
	
	case rBoardHyrule:global.shine_spawn_count = 3; break;
	
	case rBoardNsanity:
		layer_background_xscale(layer_back_id, camera_get_view_width(view_camera[0]) / sprite_get_width(sprBkgBoardNsanity));
		layer_background_yscale(layer_back_id, camera_get_view_height(view_camera[0]) / sprite_get_height(sprBkgBoardNsanity));
		break;
}