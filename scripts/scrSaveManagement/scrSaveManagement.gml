//Main data
global.file_selected = -1;
global.board_games = {};
global.game_id = "";
global.player_game_ids = [];
global.board_selected = -1;

//Global information
global.collected_shines = 0;
global.collected_coins = 0;
global.collected_skins = array_sequence(0, 4);
global.collected_achievements = [];

function save_file() {
	var save = {
		main_game: {
			saved_collected_shines: global.collected_shines,
			saved_collected_coins: global.collected_coins,
			saved_collected_skins: global.collected_skins,
			saved_collected_achievements: global.collected_achievements
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
	
	global.collected_shines = save.main_game.saved_collected_shines;
	global.collected_coins = save.main_game.saved_collected_coins;
	global.collected_skins = save.main_game.saved_collected_skins;
	global.collected_achievements = save.main_game.saved_collected_achievements;
	global.board_games = save.board_games;
	
	return true;
}

function save_board() {
	var board = {
		saved_id: global.player_id,
		saved_ai_count: get_ai_count(),
		saved_board: {
			saved_board: global.board_selected,
			saved_max_turns: global.max_board_turns,
			saved_turn: global.board_turn,
			saved_shine_position: [objShine.x, objShine.y],
			saved_spaces: [],
			saved_first_space: global.board_first_space,
			saved_minigame_history: global.minigame_history
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
