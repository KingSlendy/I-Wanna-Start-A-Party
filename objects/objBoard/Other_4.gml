if (IS_BOARD) {
	//Load game
	if (array_length(global.player_game_ids) > 0) {
		global.board_started = true;
		var board = global.board_games[$ global.game_id];
		global.max_board_turns = board.saved_board.saved_max_turns;
		global.board_turn = board.saved_board.saved_turn;
		global.board_first_space = board.saved_board.saved_first_space;
		global.seed_bag = board.saved_board.saved_seed_bag;
		global.minigame_history = board.saved_board.saved_minigame_history;
	
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
			for (var j = 1; j <= global.player_max; j++) {
				if (i == global.player_game_ids[j - 1]) {
					var saved_player = board.saved_players[j - 1];
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
					player_info.items = [];
				
					for (var k = 0; k < array_length(player_info.items); k++) {
						var item = saved_player.saved_items[k];
					
						if (item != -1) {
							player_info.items[k] = global.board_items[item];
						} else {
							player_info.items[k] = null;
						}
					}
				
					player_info.item_effect = (saved_player.saved_item_effect != -1) ? saved_player.saved_item_effect : null;
				
					break;
				}
			}
		}
	
		calculate_player_place();
		global.player_game_ids = [];
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
