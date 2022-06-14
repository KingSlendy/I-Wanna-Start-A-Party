if (IS_BOARD) {
	if (array_length(global.player_game_ids) > 0) { //Load board
		global.board_started = true;
		var board = global.board_games[$ global.game_id];
		global.max_board_turns = board.saved_board.saved_max_turns;
		global.board_turn = board.saved_board.saved_turn;
		global.board_first_space = board.saved_board.saved_first_space;
		global.minigame_history = board.saved_board.saved_minigame_history;
	
		if (global.game_id != "Offline") {
			var split = string_split(global.game_id, " ");
			var seed = split[array_length(split) - 1];
			random_set_seed(seed + 333 * (global.board_turn - 1));
		}
		
		generate_seed_bag();
	
		with (instance_create_layer(board.saved_board.saved_shine_position[0], board.saved_board.saved_shine_position[1], "Actors", objShine)) {
			image_xscale = 1;
			image_yscale = 1;
			spawning = false;
			floating = true;
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
		}
	
		calculate_player_place();
		global.player_game_ids = [];
	} else { //Initialize board
		generate_seed_bag();
		
		if (instance_exists(objNetworkClient)) {
			global.game_id = date_datetime_string(date_current_datetime()) + " " + string(get_timer()) + " " + string(irandom(9999999));
		} else {
			global.game_id = "Offline";
		}
		
		global.initial_rolls = array_sequence(1, 10);
		array_shuffle(global.initial_rolls);
		array_delete(global.initial_rolls, global.player_max, array_length(global.initial_rolls) - global.player_max);
	}

	if (!global.board_started) {
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
}
