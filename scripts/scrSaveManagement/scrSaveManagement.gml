global.board_games = {};
global.load_board = false;

function save_file() {
	return;
	
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
	return;
	
	var buffer = buffer_load("Save");
	buffer_seek_begin(buffer);
	var data = buffer_read(buffer, buffer_string);
	var save = json_parse(data);
	
	global.board_games = save.board_games;
}

function save_board() {
	return;
	
	var board = {
		saved_board: {
			saved_max_turns: global.max_board_turns,
			saved_turn: global.board_turn,
			saved_shine_position: [objShine.x, objShine.y],
			saved_spaces: [],
			saved_first_space: global.board_first_space
		},
		
		saved_players: {}
	};
	
	with (objSpaces) {
		array_push(board.saved_board.saved_spaces, [x, y, image_index]);
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		if (is_player_local(i)) {
			var player = focus_player_by_id(i);
			var player_info = player_info_by_id(i);
			
			board.saved_players[$ player.network_name] = {
				saved_skin: player.skin,
				saved_turn: player_info.turn,
				saved_shines: player_info.shines,
				saved_coins: player_info.coins,
				saved_items: player_info.items,
				saved_place: player_info.place,
				saved_item_effect: player_info.item_effect,
				saved_position: [player.x, player.y],
			};
		}
	}
	
	global.board_games[$ global.game_id] = board;
	save_file();
}
