function Board(name, scene, makers, welcome, rules) constructor {
	self.name = name;
	self.scene = scene;
	self.makers = makers;
	self.welcome = welcome;
	self.rules = rules;
	self.alright = language_get_text("PARTY_BOARD_ALRIGHT");
}

function board_init() {
	global.boards = [
		new Board(language_get_text("PARTY_BOARD_ISLAND_NAME"), rBoardIsland, "KingSlendy\nJPRG666", language_get_text("PARTY_BOARD_ISLAND_WELCOME"), [language_get_text("PARTY_BOARD_ISLAND_RULES_1"), language_get_text("PARTY_BOARD_ISLAND_RULES_2"), language_get_text("PARTY_BOARD_ISLAND_RULES_3", ["{40 coins}", draw_coins_price(40)], ["{30 coins}", draw_coins_price(30)], ["{10 coins}", draw_coins_price(10)], ["{0 coins}", draw_coins_price(0)])]),
		new Board(language_get_text("PARTY_BOARD_HOTLAND_NAME"), rBoardHotland, "KingSlendy\nJPRG666", language_get_text("PARTY_BOARD_HOTLAND_WELCOME"), [language_get_text("PARTY_BOARD_HOTLAND_RULES_1"), language_get_text("PARTY_BOARD_HOTLAND_RULES_2")]),
		new Board(language_get_text("PARTY_BOARD_BABA_NAME"), rBoardBaba, "KingSlendy", language_get_text("PARTY_BOARD_BABA_WELCOME"), [language_get_text("PARTY_BOARD_BABA_RULES_1"), language_get_text("PARTY_BOARD_BABA_RULES_2"), language_get_text("PARTY_BOARD_BABA_RULES_3")]),
		new Board(language_get_text("PARTY_BOARD_PALLET_NAME"), rBoardPallet, "KingSlendy", language_get_text("PARTY_BOARD_PALLET_WELCOME"), [language_get_text("PARTY_BOARD_PALLET_RULES_1"), language_get_text("PARTY_BOARD_PALLET_RULES_2", ["{15 coins}", draw_coins_price(15)]), language_get_text("PARTY_BOARD_PALLET_RULES_3", ["{10 coins}", draw_coins_price(10)], ["{10 coins}", draw_coins_price(10)]), language_get_text("PARTY_BOARD_PALLET_RULES_4"), language_get_text("PARTY_BOARD_PALLET_RULES_5"), language_get_text("PARTY_BOARD_PALLET_RULES_6")]),
		new Board(language_get_text("PARTY_BOARD_DREAMS_NAME"), rBoardDreams, "Kogami Takara\nKingSlendy", language_get_text("PARTY_BOARD_DREAMS_WELCOME"), [language_get_text("PARTY_BOARD_DREAMS_RULES_1"), language_get_text("PARTY_BOARD_DREAMS_RULES_2")]),
		new Board(language_get_text("PARTY_BOARD_HYRULE_NAME"), rBoardHyrule, "KingSlendy", language_get_text("PARTY_BOARD_HYRULE_WELCOME"), [language_get_text("PARTY_BOARD_HYRULE_RULES_1"), language_get_text("PARTY_BOARD_HYRULE_RULES_2"), language_get_text("PARTY_BOARD_HYRULE_RULES_3"), language_get_text("PARTY_BOARD_HYRULE_RULES_4", ["{20 coins}", draw_coins_price(20)]), language_get_text("PARTY_BOARD_HYRULE_RULES_5")]),
		new Board(language_get_text("PARTY_BOARD_NSANITY_NAME"), rBoardNsanity, "KingSlendy\nMauriPlays!", language_get_text("PARTY_BOARD_NSANITY_WELCOME"), [language_get_text("PARTY_BOARD_NSANITY_RULES_1"), language_get_text("PARTY_BOARD_NSANITY_RULES_2", ["{5 coins}", draw_coins_price(5)], ["{10 coins}", draw_coins_price(10)])]),
		new Board(language_get_text("PARTY_BOARD_WORLD_NAME"), rBoardWorld, "Kogami Takara\nKingSlendy", language_get_text("PARTY_BOARD_WORLD_WELCOME"), [language_get_text("PARTY_BOARD_WORLD_RULES_1"), language_get_text("PARTY_BOARD_WORLD_RULES_2")]),
		new Board(language_get_text("PARTY_BOARD_FASF_NAME"), rBoardFASF, "Neos\nKingSlendy", language_get_text("PARTY_BOARD_FASF_WELCOME"), [language_get_text("PARTY_BOARD_FASF_RULES_1"), language_get_text("PARTY_BOARD_FASF_RULES_2"), language_get_text("PARTY_BOARD_FASF_RULES_3"), language_get_text("PARTY_BOARD_FASF_RULES_4")])
	];
}

function board_collect(board) {
	array_push(global.collected_boards, board);
	array_sort(global.collected_boards, true);
	save_file();
}

function board_collected(board) {
	return array_search(global.collected_boards, board);
}

global.board_path_finding_look = false;

function board_music() {
	var room_name = room_get_name(room);
	var bgm_name = $"bgm{string_copy(room_name, 2, string_length(room_name) - 1)}";
	
	//Island Board
	if (room == rBoardIsland && !global.board_day) {
		bgm_name += "Night";
	}
	
	//Hyrule Board
	if (room == rBoardHyrule && !global.board_light) {
		bgm_name += "Dark";
	}
	
	//FASF Board
	if (room == rBoardFASF && global.board_fasf_last5turns_event && (global.board_turn > global.max_board_turns - 5)) {
		bgm_name += "Last5Turns";	
	}
	
	music_play_from_position(audio_get_index(bgm_name), global.board_music_track_position);
}

function board_save_track_position() {
	global.board_music_track_position = audio_sound_get_track_position(global.music_current);
}

function board_reset_track_position() {
	global.board_music_track_position = 0;
}

function board_hotland_annoying_dog() {
	instance_create_layer(0, 0, "Managers", objBoardHotlandAnnoyingDog);
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.BoardHotlandAnnoyingDog);
		network_send_tcp_packet();
	}
}

function board_baba_blocks(block_id) {
	global.baba_block_id = block_id;
	
	start_dialogue([
		new Message(language_get_text("PARTY_BOARD_BABA_BLOCKS"),, board_baba_toggle)
	]);
}

function board_baba_toggle() {
	global.baba_toggled[global.baba_block_id] ^= true;
	
	with (objBoardBabaBlock) {
		if (block_id == global.baba_block_id) {
			block_update();
			break;
		}
	}
	
	board_advance();
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.BoardBabaToggle);
		buffer_write_data(buffer_u8, global.baba_block_id);
		network_send_tcp_packet();
	}
}

function board_pallet_pokemons() {
	pokemon = collision_circle(x + 16, y + 16, 64, objBoardPalletPokemon, false, true);
	var player_info = player_info_by_turn();

	if (player_info.coins >= global.pokemon_price) {
		bring_dialogues = [
			new Message(language_get_text("PARTY_BOARD_PALLET_POKEMON_HAPPY"),, function() {
				change_coins(-global.pokemon_price, CoinChangeType.Spend).final_action = function() {
					board_pallet_obtain(pokemon.sprite_index);
				}
			})
		];
	} else {
		bring_dialogues = [
			new Message(language_get_text("PARTY_BOARD_PALLET_POKEMON_DONT_HAVE", ["{15 coins}", draw_coins_price(global.pokemon_price)]),, board_advance)
		];
	}
	
	if (player_info.pokemon != -1) {
		battle_dialogues = [
			new Message(language_get_text("PARTY_BOARD_PALLET_POKEMON_BEST_SHOT"),, function() {
				board_pallet_battle(pokemon.sprite_index);
			})
		]
	} else {
		battle_dialogues = [
			new Message(language_get_text("PARTY_BOARD_PALLET_POKEMON_CANT_BATTLE"),, board_advance)
		];
	}

	var type = pokemon.power_type;
	
	switch (type) {
		case "Water": language_get_text("PARTY_BOARD_PALLET_POKEMON_TYPE_WATER"); break;
		case "Grass": language_get_text("PARTY_BOARD_PALLET_POKEMON_TYPE_GRASS"); break;
		case "Fire": language_get_text("PARTY_BOARD_PALLET_POKEMON_TYPE_FIRE"); break;
	}

	start_dialogue([
		language_get_text("PARTY_BOARD_PALLET_POKEMON_ENCOUNTER", ["{Type}", type]),
		new Message(language_get_text("PARTY_BOARD_PALLET_POKEMON_WITH_IT"), [
			[language_get_text("PARTY_BOARD_PALLET_POKEMON_BRING", ["{15 coins}", draw_coins_price(global.pokemon_price)]), bring_dialogues],
			[language_get_text("PARTY_BOARD_PALLET_POKEMON_BATTLE"), battle_dialogues],
			
			[language_get_text("WORD_GENERIC_PASS"), [
				new Message(language_get_text("PARTY_BOARD_PALLET_POKEMON_SEE_YOU"),, board_advance)
			]]
		])
	]);
}

function board_pallet_obtain(pokemon) {
	instance_create_layer(0, 0, "Managers", objBoardPalletObtain, {
		sprite: pokemon
	});
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.BoardPalletObtain);
		buffer_write_data(buffer_u16, pokemon);
		network_send_tcp_packet();
	}
}

function board_pallet_battle(pokemon) {
	instance_create_layer(0, 0, "Managers", objBoardPalletBattle, {
		sprite: pokemon
	});
	
	//if (is_local_turn()) {
	//	buffer_seek_begin();
	//	buffer_write_action(ClientTCP.BoardPalletBattle);
	//	buffer_write_data(buffer_u16, pokemon);
	//	network_send_tcp_packet();
	//}
}

function board_dreams_teleports(reference) {
	var player = focused_player();
	
	with (objPlayerReference) {
		if (self.reference == reference) {
			if (global.board_path_finding_look) {
				return id;
			}
			
			player.x = x + 16;
			player.y = y + 16;
			break;
		}
	}
	
	switch_camera_target(player.x, player.y).final_action = board_advance;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.BoardDreamsTeleports);
		buffer_write_data(buffer_u8, reference);
		network_send_tcp_packet();
	}
	
	return null;
}

function board_nsanity_return() {
	instance_create_layer(0, 0, "Managers", objBoardNsanityReturn);
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.BoardNsanityReturn);
		network_send_tcp_packet();
	}
}

function board_world_scott_interact() {
	var player = focused_player();
	var texts;
	global.player_ghost_shines = [];
	global.player_ghost_turn = global.player_turn;
	
	if (is_player_turn()) {
		global.player_ghost_shines = [player.network_id];
		
		if (player.network_id == global.player_id) {
			if (!objBoardWorldGhost.encountered) {
				objBoardWorldGhost.encountered = true;
			} else {
				achieve_trophy(97);
			}
		}
	} else {
		with (player) {
			var list = ds_list_create();
			var count = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, objPlayerBase, false, true, list, false);
			
			for (var i = 0; i < count; i++) {
				array_push(global.player_ghost_shines, list[| i].network_id);
			}
			
			ds_list_destroy(list);
			array_sort(global.player_ghost_shines, function(a, b) { return player_info_by_id(a).turn - player_info_by_id(b).turn; });
		}
	}
	
	board_world_ghost_switch(is_player_turn());
}

function board_world_ghost_switch(network = true) {
	if (array_length(global.player_ghost_shines) == 0) {
		with (objBoard) {
			alarm_next(7);
		}

		return;
	}
	
	switch_camera_target(objCamera.target_follow.x, objCamera.target_follow.y).final_action = board_world_ghost_texts;
	var player = focus_player_by_id(global.player_ghost_shines[0]);
	global.player_ghost_previous = player_info_by_id(player.network_id).turn;
	
	if (network && is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.BoardWorldGhostSwitch);
		buffer_write_array(buffer_u8, global.player_ghost_shines);
		buffer_write_data(buffer_u8, global.player_ghost_turn);
		buffer_write_data(buffer_u8, global.player_ghost_previous);
		network_send_tcp_packet();
	}
	
	global.player_turn = global.player_ghost_previous;
}

function board_world_ghost_texts() {
	if (!is_local_turn()) {
		return;
	}
	
	global.player_turn = global.player_ghost_turn;
	
	if (player_info_by_id(global.player_ghost_shines[0]).shines > 0) {
		if (is_player_turn()) {
			var text = language_get_text("PARTY_BOARD_WORLD_GHOST_TAKE_YOU");
		} else {
			var text = language_get_text("PARTY_BOARD_WORLD_GHOST_TAKE_PLAYER", ["{Color}", "{COLOR,0000FF}"], ["{Player}", focus_player_by_turn(global.player_ghost_previous).network_name], ["{Color}", "{COLOR,FFFFFF}"]);
		}
	} else {
		if (is_player_turn()) {
			var text = language_get_text("PARTY_BOARD_WORLD_GHOST_SAFE_YOU");
		} else {
			var text = language_get_text("PARTY_BOARD_WORLD_GHOST_SAFE_PLAYER", ["{Color}", "{COLOR,0000FF}"], ["{Player}", focus_player_by_turn(global.player_ghost_previous).network_name], ["{Color}", "{COLOR,FFFFFF}"]);
		}
	}
	
	global.player_turn = global.player_ghost_previous;
	start_dialogue([new Message(text,, board_world_ghost_shines)]);
}

function board_world_ghost_shines(network = true) {
	with (focus_player_by_turn(global.player_max + 1)) {
		if (player_info_by_id(global.player_ghost_shines[0]).shines > 0) {
			sprite_index = event_sprite;
			image_index = 0;
		} else {
			alarm_call(0, 0.5);
		}
	}
	
	if (network && is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.BoardWorldGhostShines);
		network_send_tcp_packet();
	}
}

function board_fasf_teleports(reference) {
	var pick_reference = reference;
	
	if (reference == 0) {
		pick_reference = irandom_range(2, 4);
	}
	
	var player = focused_player();
	
	with (objPlayerReference) {
		if (self.reference == pick_reference) {
			if (global.board_path_finding_look) {
				return id;
			}
			
			player.x = x + 16;
			player.y = y + 16;
			break;
		}
	}
	
	switch (reference) {
		case 0: global.board_fasf_space_mode = FASF_SPACE_MODES.NOTHING; break;	
		case 5: global.board_fasf_space_mode = FASF_SPACE_MODES.ICE; break;
		case 6: global.board_fasf_space_mode = FASF_SPACE_MODES.MUD; break;
		case 7: global.board_fasf_space_mode = FASF_SPACE_MODES.PORTAL; break;
	}
	
	switch_camera_target(player.x, player.y).final_action = board_advance;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.BoardFASFTeleports);
		buffer_write_data(buffer_u8, reference);
		network_send_tcp_packet();
	}
	
	return null;
}

function board_fasf_set_event(mode = false) {
	global.board_fasf_last5turns_event = mode;
}

function board_fasf_play_music() {
	music_play(bgmBoardFASFLast5Turns);
	audio_sound_gain(global.music_current, 1, 500);
}

function disable_board() {
	instance_destroy(objPlayerInfo);
	instance_destroy(objBoard);
	
	//FASF Board
	board_fasf_set_event(false);
}