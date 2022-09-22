function save_variables() {
	//Main data
	global.game_started = false;
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
	global.collected_hint_trophies = [];
	global.collected_spoiler_trophies = [];
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
			saved_collected_hint_trophies: global.collected_hint_trophies,
			saved_collected_spoiler_trophies: global.collected_spoiler_trophies,
			saved_ellapsed_time: global.ellapsed_time,
			saved_player_name: global.player_name,
			saved_ip: global.ip,
			saved_port: global.port
		},
		
		board_games: global.board_games
	};
	
	var data = json_stringify(save);
	var buffer = buffer_create(string_byte_length(data), buffer_fixed, 1);
	buffer_seek_begin(buffer);
	buffer_write(buffer, buffer_text, data);
	buffer_save(buffer, "Save" + string(global.file_selected + 1));
	buffer_delete(buffer);
}

function load_file() {
	var save_name = "Save" + string(global.file_selected + 1);
	var save_name_backup = save_name + "_Backup";
	
	if (!file_exists(save_name)) {
		return false;
	}
	
	try {
		var buffer = buffer_load(save_name);
		buffer_seek_begin(buffer);
		var data = buffer_read(buffer, buffer_text);
		var save = json_parse(data);
	} catch (_) {
		var buffer = buffer_load(save_name_backup);
		buffer_seek_begin(buffer);
		var data = buffer_read(buffer, buffer_text);
		var save = json_parse(data);
	}
	
	global.games_played = save.main_game.saved_games_played;
	global.collected_shines = save.main_game.saved_collected_shines;
	global.collected_coins = save.main_game.saved_collected_coins;
	global.seen_minigames = save.main_game.saved_seen_minigames;
	global.collected_skins = save.main_game.saved_collected_skins;
	global.collected_trophies = save.main_game.saved_collected_trophies;
	
	try {
		global.collected_hint_trophies = save.main_game.saved_collected_hint_trophies;
	} catch (_) {
		global.collected_hint_trophies = [];
	}
	
	try {
		global.collected_spoiler_trophies = save.main_game.saved_collected_spoiler_trophies;
	} catch (_) {
		global.collected_spoiler_trophies = [];
	}
	
	global.ellapsed_time = save.main_game.saved_ellapsed_time;
	global.player_name = save.main_game.saved_player_name;
	global.ip = save.main_game.saved_ip;
	global.port = save.main_game.saved_port;
	global.board_games = save.board_games;
	
	var index = array_index(global.seen_minigames, "Targetting Targets");
	
	if (index != -1) {
		global.seen_minigames[index] = "Targeting Targets";
	}
	
	return true;
}

function save_board() {
	var board = {
		saved_id: global.player_id,
		saved_ai_count: get_ai_count(),
		saved_board: {
			saved_board: global.board_selected,
			saved_max_turns: global.max_board_turns,
			saved_board_turn: global.board_turn,
			saved_board_light: global.board_light,
			saved_give_bonus_shines: global.give_bonus_shines,
			saved_shine_positions: [],
			saved_spaces: []
		},
		
		saved_players: array_create(global.player_max, null)
	};
	
	with (objShine) {
		array_push(board.saved_board.saved_shine_positions, [x, y]);
	}
	
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
			saved_bonus_shines_score: [],
			saved_pokemon: player_info.pokemon
		};
		
		var saved_player = board.saved_players[i - 1];
			
		for (var j = 0; j < array_length(player_info.items); j++) {
			var item = player_info.items[j];
				
			if (item != null) {
				item = item.id;
			} else {
				item = -1;
			}
				
			saved_player.saved_items[j] = item;
		}
		
		for (var j = 0; j < array_length(global.bonus_shines); j++) {
			saved_player.saved_bonus_shines_score[j] = global.bonus_shines[j].scores[player_info.turn - 1];
		}
	}
	
	global.board_games[$ global.game_id] = board;
	save_file();
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

function config_variables() {
	global.master_volume = 0.5;
	global.bgm_volume = 1;
	global.sfx_volume = 1;
	
	global.fullscreen_display = false;
	global.vsync_display = false;
	global.smooth_display = false;
}

function save_config() {
	var config = {
		settings: {
			saved_master_volume: global.master_volume,
			saved_bgm_volume: global.bgm_volume,
			saved_sfx_volume: global.sfx_volume,
			
			saved_fullscreen_display: global.fullscreen_display,
			saved_vsync_display: global.vsync_display,
			saved_smooth_display: global.smooth_display
		}
	};
	
	var data = json_stringify(config);
	var buffer = buffer_create(string_byte_length(data), buffer_fixed, 1);
	buffer_seek_begin(buffer);
	buffer_write(buffer, buffer_text, data);
	buffer_save(buffer, "Config");
	buffer_delete(buffer);
}

function load_config() {
	if (!file_exists("Config")) {
		return false;
	}
	
	var buffer = buffer_load("Config");
	buffer_seek_begin(buffer);
	var data = buffer_read(buffer, buffer_text);
	var config = json_parse(data);
	
	global.master_volume = config.settings.saved_master_volume;
	global.bgm_volume = config.settings.saved_bgm_volume;
	global.sfx_volume = config.settings.saved_sfx_volume;
	
	global.fullscreen_display = config.settings.saved_fullscreen_display;
	global.vsync_display = config.settings.saved_vsync_display;
	global.smooth_display = config.settings.saved_smooth_display;
	
	return true;
}

function apply_config() {
	apply_volume();
	apply_display();
}

function apply_volume() {
	audio_master_gain(sqr(global.master_volume));
	audio_group_set_gain(audiogroup_BGM, sqr(global.bgm_volume), 0);
	audio_group_set_gain(audiogroup_SFX, sqr(global.sfx_volume), 0);
}

function apply_display() {
	window_set_fullscreen(global.fullscreen_display);
	
	if (global.vsync_display) {
	    display_reset(0, global.vsync_display);
	}

	display_set_gui_size(surface_get_width(application_surface), surface_get_height(application_surface));
}