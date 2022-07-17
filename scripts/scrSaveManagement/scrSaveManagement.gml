function save_variables() {
	//Main data
	global.file_selected = -1;
	global.game_id = "";
	global.player_game_ids = [];
	global.board_selected = -1;

	//Global information
	global.games_played = 0;
	global.collected_shines = 0;
	global.collected_coins = 0;
	global.seen_minigames = [];
	global.collected_skins = array_sequence(0, 8);
	global.collected_trophies = [];
	global.ellapsed_time = 0;
	global.player_name = "Player";
	global.ip = "startaparty.sytes.net";
	global.port = "33321";

	//Board information
	global.board_games = {};
	global.max_board_turns = 20;
	global.give_bonus_shines = true;
}

function save_file() {
	var save_name = "Save" + string(global.file_selected + 1);
	var save_name_backup = save_name + "_Backup";
	
	if (file_exists(save_name_backup)) {
		file_delete(save_name_backup);
	}
	
	file_rename(save_name, save_name_backup);
	
	var save = {
		main_game: {
			saved_games_played: global.games_played,
			saved_collected_shines: global.collected_shines,
			saved_collected_coins: global.collected_coins,
			saved_seen_minigames: global.seen_minigames,
			saved_collected_skins: global.collected_skins,
			saved_collected_trophies: global.collected_trophies,
			saved_ellapsed_time: global.ellapsed_time,
			saved_player_name: global.player_name,
			saved_ip: global.ip,
			saved_port: global.port
		},
		
		board_games: global.board_games
	};
	
	var data = json_stringify(save);
	var buffer = buffer_create(256, buffer_grow, 1);
	buffer_seek_begin(buffer);
	buffer_write(buffer, buffer_string, data);
	buffer_save(buffer, "Save" + string(global.file_selected + 1));
	buffer_delete(buffer);
}

function load_file() {
	if (!file_exists("Save" + string(global.file_selected + 1))) {
		return false;
	}
	
	var buffer = buffer_load("Save" + string(global.file_selected + 1));
	buffer_seek_begin(buffer);
	var data = buffer_read(buffer, buffer_string);
	var save = json_parse(data);
	
	global.games_played = save.main_game.saved_games_played;
	global.collected_shines = save.main_game.saved_collected_shines;
	global.collected_coins = save.main_game.saved_collected_coins;
	global.seen_minigames = save.main_game.saved_seen_minigames;
	global.collected_skins = save.main_game.saved_collected_skins;
	
	try {
		global.collected_trophies = save.main_game.saved_collected_trophies;
	} catch (_) {
		global.collected_trophies = [];
	}
	
	try {
		global.ellapsed_time = save.main_game.saved_ellapsed_time;
	} catch (_) {
		global.ellapsed_time = 0;
	}
	
	try {
		global.player_name = save.main_game.saved_player_name;
	} catch (_) {
		global.player_name = "Player";
	}
	
	try {
		global.ip = save.main_game.saved_ip;
	} catch (_) {
		global.ip = "startaparty.sytes.net";
	}
	
	try {
		global.port = save.main_game.saved_port;
	} catch (_) {
		global.port = "33321";
	}
	
	global.board_games = save.board_games;
	
	return true;
}

function delete_file() {
	var file_selected = global.file_selected;
	
	if (file_exists("Save" + string(global.file_selected + 1))) {
		file_delete("Save" + string(global.file_selected + 1));
	}
	
	save_variables();
	global.file_selected = file_selected;
	save_file();
}

function save_board() {
	var board = {
		saved_id: global.player_id,
		saved_ai_count: get_ai_count(),
		saved_board: {
			saved_board: global.board_selected,
			saved_max_turns: global.max_board_turns,
			saved_turn: global.board_turn,
			saved_give_bonus_shines: global.give_bonus_shines,
			saved_shine_positions: [],
			saved_spaces: [],
			saved_bonus_shines: []
		},
		
		saved_players: array_create(global.player_max, null)
	};
	
	with (objShine) {
		array_push(board.saved_board.saved_shine_positions, [x, y]);
	}
	
	with (objSpaces) {
		array_push(board.saved_board.saved_spaces, [x, y, image_index]);
	}
	
	for (var i = 0; i < array_length(global.bonus_shines); i++) {
		board.saved_board.saved_bonus_shines[i] = global.bonus_shines[i].scores;
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
