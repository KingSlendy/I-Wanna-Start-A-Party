function save_variables() {
	//Main data
	global.game_started = false;
	global.file_selected = -1;
	global.game_id = "";
	global.game_key = "";
	global.player_game_ids = [];
	global.board_selected = -1;

	//Party
	global.games_played = 0;
	global.collected_shines = 0;
	global.collected_coins = 0;
	global.collected_boards = array_sequence(0, 3);
	
	//Minigames
	global.seen_minigames = [];
	
	//Trials
	global.collected_trials = [];
	global.beaten_trials = [];
	
	//Store
	global.collected_skins = array_sequence(0, 8);
	global.collected_reactions = array_sequence(0, 4);
	
	//Trophies
	global.collected_trophies = [];
	global.collected_hint_trophies = [];
	global.collected_spoiler_trophies = [];
	
	//Misc
	global.saved_times = 0;
	global.ellapsed_time = 0;
	global.player_name = DEFAULT_PLAYER;
	global.ip = DEFAULT_IP;
	global.port = DEFAULT_PORT;

	//Board information
	global.board_games = {};
	global.max_board_turns = 20;
	global.give_bonus_shines = true;
}

function save_file() {
	var save_name = "Save" + string(global.file_selected + 1);
	var save_name_backup = save_name + "_Backup";

	if (global.saved_times == 3) {
		if (file_exists(save_name_backup)) {
			file_delete(save_name_backup);
		}
		
		file_rename(save_name, save_name_backup);
		global.saved_times = 0;
	}
	
	var save = {
		main_game: {
			saved_games_played: global.games_played,
			saved_collected_shines: global.collected_shines,
			saved_collected_coins: global.collected_coins,
			saved_collected_boards: global.collected_boards,
			saved_seen_minigames: global.seen_minigames,
			saved_collected_trials: global.collected_trials,
			saved_beaten_trials: global.beaten_trials,
			saved_collected_skins: global.collected_skins,
			saved_collected_reactions: global.collected_reactions,
			saved_collected_trophies: global.collected_trophies,
			saved_collected_hint_trophies: global.collected_hint_trophies,
			saved_collected_spoiler_trophies: global.collected_spoiler_trophies,
			saved_times: ++global.saved_times,
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
	buffer_save(buffer, save_name);
	buffer_delete(buffer);
}

function load_file() {
	var save_name = "Save" + string(global.file_selected + 1);
	var save_name_backup = save_name + "_Backup";
	
	if (!file_exists(save_name) && !file_exists(save_name_backup)) {
		return false;
	}
	
	var buffer = noone;
	
	try {
		buffer = buffer_load(save_name);
		buffer_seek_begin(buffer);
		var data = buffer_read(buffer, buffer_text);
		var save = json_parse(data);
	} catch (_) {
		if (buffer_exists(buffer)) {
			buffer_delete(buffer);
		}
		
		buffer = buffer_load(save_name_backup);
		buffer_seek_begin(buffer);
		var data = buffer_read(buffer, buffer_text);
		var save = json_parse(data);
	}
	
	global.games_played = save.main_game.saved_games_played;
	global.collected_shines = save.main_game.saved_collected_shines;
	global.collected_coins = save.main_game.saved_collected_coins;
	
	try {
		global.collected_boards = save.main_game.saved_collected_boards;
	} catch (_) {
		global.collected_boards = array_sequence(0, 3);
	}
	
	global.collected_boards = array_unique(global.collected_boards);
	global.seen_minigames = save.main_game.saved_seen_minigames;
	var index = array_get_index(global.seen_minigames, "Dinnyamic Duos");
	
	if (index != -1) {
		global.seen_minigames[index] = "Dynyaamic Duos";
	}
	
	try {
		global.collected_trials = save.main_game.saved_collected_trials;
	} catch (_) {
		global.collected_trials = [];
	}
	
	global.collected_trials = array_unique(global.collected_trials);
	
	try {
		global.beaten_trials = save.main_game.saved_beaten_trials;
	} catch (_) {
		global.beaten_trials = [];
	}
	
	global.beaten_trials = array_unique(global.beaten_trials);
	global.collected_skins = save.main_game.saved_collected_skins;
	global.collected_skins = array_unique(global.collected_skins);
	
	try {
		global.collected_reactions = save.main_game.saved_collected_reactions;
	} catch (_) {
		global.collected_reactions = array_sequence(0, 4);
	}
	
	global.collected_reactions = array_unique(global.collected_reactions);
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
	
	try {
		global.saved_times = save.main_game.saved_times;
	} catch (_) {
		global.saved_times = 0;
	}
	
	global.ellapsed_time = save.main_game.saved_ellapsed_time;
	global.player_name = save.main_game.saved_player_name;
	global.ip = save.main_game.saved_ip;
	global.port = save.main_game.saved_port;
	global.board_games = save.board_games;
	
	return true;
}

function save_board() {
	var board = {
		saved_key: global.game_key,
		saved_ai_count: get_ai_count(),
		saved_id: global.player_id,
		saved_board: {
			saved_board: global.board_selected,
			saved_max_turns: global.max_board_turns,
			saved_board_turn: global.board_turn,
			saved_give_bonus_shines: global.give_bonus_shines,
			saved_shine_positions: [],
			saved_spaces: [],
			
			//Baba Board
			saved_baba_toggled: global.baba_toggled,
			
			//Hyrule Board
			saved_board_light: global.board_light,
			
			//World Board
			saved_ghost_position: {},
			
			//FASF Board
			saved_fasf_space_mode: global.board_fasf_space_mode,
			saved_fasf_last5turns: global.board_fasf_last5turns_event
		},
		
		saved_players: array_create(global.player_max, null)
	};
	
	with (objShine) {
		array_push(board.saved_board.saved_shine_positions, [x, y]);
	}
	
	with (objSpaces) {
		array_push(board.saved_board.saved_spaces, [x, y, image_index]);
	}
	
	with (objBoardWorldGhost) {
		board.saved_board.saved_ghost_position = {x: self.x, y: self.y};	
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
			
			//Pallet Board
			saved_pokemon: (player_info.pokemon != -1) ? sprite_get_name(player_info.pokemon) : -1
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

function load_board() {
	var board = global.board_games[$ global.game_id];
	global.max_board_turns = board.saved_board.saved_max_turns;
	global.board_turn = board.saved_board.saved_board_turn;
	global.give_bonus_shines = board.saved_board.saved_give_bonus_shines;
		
	//Baba Board
	global.baba_toggled = board.saved_board.saved_baba_toggled;
		
	//Hyrule Board
	global.board_light = board.saved_board.saved_board_light;
		
	//FASF Board
	global.board_fasf_space_mode = board.saved_board.saved_fasf_space_mode;
	global.board_fasf_last5turns_event = board.saved_board.saved_fasf_last5turns;
		
	//World Board
	with (objBoardWorldGhost) {
		var position = board.saved_board.saved_ghost_position;
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
		player_info.pokemon = (saved_player.saved_pokemon != -1) ? asset_get_index(saved_player.saved_pokemon) : -1;
	}
}

function restore_file() {
	var file_selected = global.file_selected;
	var save_name = "Save" + string(file_selected + 1);
	var save_name_backup = save_name + "_Backup";
	
	if (!file_exists(save_name_backup)) {
		return;
	}
	
	file_delete(save_name);
	file_rename(save_name_backup, save_name);
	load_file();
}

function delete_file() {
	var file_selected = global.file_selected;
	var save_name = "Save" + string(file_selected + 1);
	var save_name_backup = save_name + "_Backup";
	var save_name_backup_temp = save_name_backup + "_Temp";
	
	if (!file_exists(save_name)) {
		return;
	}
	
	file_rename(save_name, save_name_backup_temp);
	save_variables();
	global.file_selected = file_selected;
	global.saved_times = 0;
	save_file();
	file_rename(save_name_backup_temp, save_name_backup);
}

function config_variables() {
	global.master_volume = 0.5;
	global.bgm_volume = 1;
	global.sfx_volume = 1;
	
	global.fullscreen_display = false;
	global.vsync_display = false;
	global.smooth_display = false;
	
	global.language_game = "English";
	var os_language = string_upper(os_get_language());
	var codes = variable_struct_get_names(global.language_codes);
	
	for (var i = 0; i < array_length(codes); i++) {
		var code = codes[i];
		
		if (os_language == global.language_codes[$ code]) {
			global.language_game = code;
		}
	}
	
	global.controls_hotswap = true;
}

function save_config() {
	var config = {
		settings: {
			saved_master_volume: global.master_volume,
			saved_bgm_volume: global.bgm_volume,
			saved_sfx_volume: global.sfx_volume,
			
			saved_fullscreen_display: global.fullscreen_display,
			saved_vsync_display: global.vsync_display,
			saved_smooth_display: global.smooth_display,
			
			saved_language_game: global.language_game,
			
			saved_controls_keyboard_and_mouse: input_profile_export("keyboard_and_mouse"),
			saved_controls_gamepad: input_profile_export("gamepad"),
			saved_controls_hotswap: global.controls_hotswap
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
	
	try {
		global.language_game = config.settings.saved_language_game;
	} catch (_) {
		var os_language = os_get_language();
		var codes = variable_struct_get_names(global.language_codes);
	
		for (var i = 0; i < array_length(codes); i++) {
			var code = codes[i];
		
			if (os_language == global.language_codes[$ code]) {
				global.language_game = code;
			}
		}
	}
	
	try {
		input_profile_import(config.settings.saved_controls_keyboard_and_mouse, "keyboard_and_mouse");
		input_profile_import(config.settings.saved_controls_gamepad, "gamepad");
	} catch (_) {}
	
	try {
		global.controls_hotswap = config.settings.saved_controls_hotswap;
	} catch (_) {
		global.controls_hotswap = true;
	}
	
	return true;
}

function apply_config() {
	apply_volume();
	apply_display();
	apply_hotswap();
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

function apply_hotswap() {
	input_source_mode_set((global.controls_hotswap) ? INPUT_SOURCE_MODE.HOTSWAP : INPUT_SOURCE_MODE.FIXED);
}