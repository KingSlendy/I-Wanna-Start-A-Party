global.board_games = {};
global.game_id = "";
global.player_game_ids = [];
global.board_selected = -1;

function save_file() {
	var save = {
		board_games: global.board_games
	};
	
	var data = json_stringify(save);
	var buffer = buffer_create(256, buffer_grow, 1);
	buffer_seek_begin(buffer);
	buffer_write(buffer, buffer_string, data);
	buffer_save(buffer, "Save");
	buffer_delete(buffer);
}

function load_file() {
	if (!file_exists("Save")) {
		return;
	}
	
	var buffer = buffer_load("Save");
	buffer_seek_begin(buffer);
	var data = buffer_read(buffer, buffer_string);
	var save = json_parse(data);
	
	global.board_games = save.board_games;
}

function save_board() {
	var board = {
		saved_id: global.player_id,
		saved_board: {
			saved_board: global.board_selected,
			saved_max_turns: global.max_board_turns,
			saved_turn: global.board_turn,
			saved_shine_position: [objShine.x, objShine.y],
			saved_spaces: [],
			saved_first_space: global.board_first_space,
			saved_minigame_history: global.minigame_history,
			saved_seed_bag: global.seed_bag
		},
		
		saved_players: array_create(global.player_max, null)
	};
	
	with (objSpaces) {
		array_push(board.saved_board.saved_spaces, [x, y, image_index]);
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_id(i);
		var player_info = player_info_by_id(i);
			
		board.saved_players[i - 1] = {
			saved_skin: sprite_get_name(get_skin_pose_object(player, "Idle")),
			saved_turn: player_info.turn,
			saved_shines: player_info.shines,
			saved_coins: player_info.coins,
			saved_items: array_create(array_length(player_info.items), -1),
			saved_item_effect: player_info.item_effect ?? -1,
			saved_position: [player.x, player.y],
		};
			
		for (var j = 0; j < array_length(player_info.items); j++) {
			var item = player_info.items[j];
				
			if (item != null) {
				item = item.id;
			} else {
				item = -1;
			}
				
			board.saved_players[i - 1].saved_items[j] = item;
		}
	}
	
	global.board_games[$ global.game_id] = board;
	save_file();
}
