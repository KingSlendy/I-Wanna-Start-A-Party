if (!IS_BOARD) {
	exit;
}

if (!global.board_started) {
	with (objPlayerBase) {
		change_to_object(objPlayerBoard);
	}
	
	if (HAS_SAVED) { //Load board
		global.board_started = true;
		var board = global.board_games[$ global.game_id];
		global.max_board_turns = board.saved_board.saved_max_turns;
		global.board_turn = board.saved_board.saved_board_turn;
		global.minigame_history = board.saved_board.saved_minigame_history;
		global.minigame_type_history = board.saved_board.saved_minigame_type_history;
		global.give_bonus_shines = board.saved_board.saved_give_bonus_shines;
		
		//Baba Board
		global.baba_toggled = board.saved_board.saved_baba_toggled;
		
		//Hyrule Board
		global.board_light = board.saved_board.saved_board_light;
		
		//World Board
		with (objBoardWorldScott) {
			var position;
			
			if (object_index == objBoardWorldNega) {
				position = board.saved_board.saved_nega_position;
			} else {
				position = board.saved_board.saved_scott_position;
			}
			
			x = position.x;
			y = position.y;
		}
	
		for (var i = 0; i < array_length(board.saved_board.saved_shine_positions); i++) {
			var position = board.saved_board.saved_shine_positions[i];
			
			with (instance_create_layer(position[0], position[1], "Actors", objShine)) {
				image_xscale = 1;
				image_yscale = 1;
				spawning = false;
				floating = true;
			}
		}
	
		for (var i = 0; i < array_length(board.saved_board.saved_spaces); i++) {
			var space = board.saved_board.saved_spaces[i];
	
			with (objSpaces) {
				if (x == space[0] && y == space[1]) {
					image_index = space[2];
					break;
				}
			}
		}
	
		for (var i = 1; i <= global.player_max; i++) {
			var saved_player = board.saved_players[global.player_game_ids[i - 1] - 1];
			var player = focus_player_by_id(i);
			var sprite = asset_get_index(saved_player.saved_skin);
			player.sprite_index = sprite;
			player.skin = get_skin_by_sprite(sprite);
			player.x = saved_player.saved_position[0];
			player.y = saved_player.saved_position[1];
			spawn_player_info(i, saved_player.saved_turn);
			var player_info = player_info_by_id(i);
			player_info.shines = saved_player.saved_shines;
			player_info.coins = saved_player.saved_coins;
				
			for (var j = 0; j < array_length(player_info.items); j++) {
				var item = saved_player.saved_items[j];
					
				if (item != -1) {
					player_info.items[j] = global.board_items[item];
				} else {
					player_info.items[j] = null;
				}
			}
				
			player_info.item_effect = (saved_player.saved_item_effect != -1) ? saved_player.saved_item_effect : null;
			
			for (var j = 0; j < array_length(global.bonus_shines); j++) {
				global.bonus_shines[j].scores[player_info.turn - 1] = saved_player.saved_bonus_shines_score[j];
			}
			
			//Pallet Board
			player_info.pokemon = saved_player.saved_pokemon;
		}
	
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
	
	case rBoardHyrule: global.shine_spawn_count = 3; break;
	
	case rBoardNsanity:
		layer_background_xscale(layer_back_id, camera_get_view_width(view_camera[0]) / sprite_get_width(sprBkgBoardNsanity));
		layer_background_yscale(layer_back_id, camera_get_view_height(view_camera[0]) / sprite_get_height(sprBkgBoardNsanity));
		break;
		
	case rBoardWorld: global.shine_spawn_count = 0; break;
}