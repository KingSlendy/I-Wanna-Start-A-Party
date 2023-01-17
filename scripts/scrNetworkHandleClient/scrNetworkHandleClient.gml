enum ClientVER {
	SendVersion,
	Executable
}

#region TCP
enum ClientTCP {
	#region Networking
	ReceiveMasterID,
	ReceiveID,
	PlayerConnect,
	PlayerDisconnect,
	CreateLobby,
	JoinLobby,
	LeaveLobby,
	LobbyList,
	LobbyStart,
	LobbyKick,
	BoardGameID,
	BoardPlayerIDs,
	ModesAction,
	BoardRandom,
	PlayerShoot,
	PlayerKill,
	#endregion
	
	#region Interactables
	ShowDice,
	RollDice,
	HideDice,
	ShowChest,
	OpenChest,
	SpawnChanceTimeBox,
	SpawnLastTurnsBox,
	#endregion
	
	#region Interfaces
	SpawnPlayerInfo,
	Reaction,
	ChangeChoiceAlpha,
	ShowMap,
	EndMap,
	LessRoll,
	SkipDialogueText,
	ChangeDialogueText,
	EndDialogue,
	ShowShop,
	EndShop,
	ShowBlackhole,
	EndBlackhole,
	ShowMultipleChoices,
	ChangeMultipleChoiceSelected,
	EndMultipleChoices,
	HitChanceTimeBox,
	HitLastTurnsBox,
	#endregion
	
	#region Stats
	ChangeShines,
	ChangeCoins,
	ChangeItems,
	ChangeSpace,
	#endregion
	
	#region Events
	BoardStart,
	TurnStart,
	TurnNext,
	ChooseShine,
	StartChanceTime,
	RepositionChanceTime,
	EndChanceTime,
	ChooseMinigame,
	StartTheGuy,
	ShowTheGuyOptions,
	EndTheGuy,
	LastTurnsSayPlayerPlace,
	LastTurnsHelpLastPlace,
	LastTurnsEndLastTurns,
	BoardHotlandAnnoyingDog,
	BoardPalletObtain,
	BoardPalletBattle,
	BoardDreamsTeleports,
	BoardNsanityReturn,
	#endregion
	
	#region Animations
	ItemApplied,
	ItemAnimation,
	StartBlackholeSteal,
	EndBlackholeSteal,
	#endregion
	
	#region Minigames
	MinigameOverviewStart,
	MinigameFinish,
	
	#region 4vs
	Minigame4vs_Lead_Input,
	Minigame4vs_Haunted_Boo,
	Minigame4vs_Magic_Hold,
	Minigame4vs_Magic_Release,
	Minigame4vs_Magic_CurtainSwitch,
	Minigame4vs_Mansion_Door,
	Minigame4vs_Painting_Platform,
	Minigame4vs_Bugs_Counting,
	Minigame4vs_Blocks_BlockDestabilize,
	Minigame4vs_Chests_ChestSelected,
	Minigame4vs_Slime_BlockEntrance,
	Minigame4vs_Slime_SlimeShot,
	Minigame4vs_Dizzy_GrabCoin,
	Minigame4vs_Targets_DestroyTarget,
	Minigame4vs_Bullets_Stop,
	Minigame4vs_Drawn_CollectKey,
	Minigame4vs_Bubble_Goal,
	Minigame4vs_Sky_Points,
	Minigame4vs_Golf_GivePoints,
	Minigame4vs_Jingle_SledgeShoot,
	Minigame4vs_Jingle_SledgeJump,
	Minigame4vs_Jingle_SledgeHit,
	#endregion
	
	#region 1vs3
	Minigame1vs3_Avoid_Block,
	Minigame1vs3_Conveyor_Switch,
	Minigame1vs3_Showdown_Block,
	Minigame1vs3_Coins_Coin,
	Minigame1vs3_Race_Solo,
	Minigame1vs3_Race_Team,
	Minigame1vs3_Warping_Push,
	Minigame1vs3_Warping_Warp,
	Minigame1vs3_Hunt_ReticleShoot,
	Minigame1vs3_Hunt_ReticleMove,
	Minigame1vs3_Aiming_LaserShoot,
	Minigame1vs3_Aiming_DestroyBlock,
	Minigame1vs3_Host_SetPickDoor,
	Minigame1vs3_House_CherryMove,
	Minigame1vs3_House_CherryJump,
	#endregion
	
	#region 2vs2
	Minigame2vs2_Maze_Item,
	Minigame2vs2_Fruits_Fruit,
	Minigame2vs2_Buttons_Button,
	Minigame2vs2_Colorful_PatternMoveVertical,
	Minigame2vs2_Colorful_PatternMoveHorizontal,
	Minigame2vs2_Colorful_PatternSelect,
	Minigame2vs2_Duos_Button,
	Minigame2vs2_Duel_Shot,
	Minigame2vs2_Soccer_Goal,
	Minigame2vs2_Idol_WhacIdol,
	#endregion
	#endregion
	
	#region Results
	ResultsBonus,
	ResultsBonusShineGoUp,
	ResultsBonusShineNextBonus,
	ResultsWon,
	ResultsEnd,
	ResultsProceed
	#endregion
}

global.tcp_functions = {};
var f = global.tcp_functions;

#region Networking
f[$ ClientTCP.ReceiveMasterID] = function(buffer) {
	global.master_id = buffer_read(buffer, buffer_u64);
			
	with (objNetworkClient) {
		alarm_frames(1, 1);
	}
}

f[$ ClientTCP.ReceiveID] = function(buffer) {
	global.player_id = buffer_read(buffer, buffer_u8);
	player_join_all();
			
	with (objFiles) {
		online_reading = false;
		menu_type = 5;
		menu_selected[menu_type] = 0;
		upper_type = menu_type;
		upper_text = lobby_texts[0];
	}
}

f[$ ClientTCP.PlayerConnect] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	player_join(player_id);
}

f[$ ClientTCP.PlayerDisconnect] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	player_leave(player_id);
}

f[$ ClientTCP.CreateLobby] = function(buffer) {
	var same_name = buffer_read(buffer, buffer_bool);
	var seed = buffer_read(buffer, buffer_u64);
	random_set_seed(seed);
	generate_seed_bag();
	objFiles.online_reading = false;
			
	if (same_name) {
		popup("A lobby with that name already exists!");
		return;
	}
		
	buffer_seek_begin();
	buffer_write_action(ClientTCP.ReceiveID);
	buffer_write_data(buffer_u64, global.master_id);
	network_send_tcp_packet();
}

f[$ ClientTCP.JoinLobby] = function(buffer) {
	var state = buffer_read(buffer, buffer_u8);
	var seed = buffer_read(buffer, buffer_u64);
	random_set_seed(seed);
	generate_seed_bag();
	objFiles.online_reading = false;
			
	switch (state) {
		case 0: popup("A lobby with that name doesn't exist or the password is incorrect."); return;
		case 2: popup("That lobby is already full."); return;
		case 3: popup("This lobby has already been started."); return;
	}
			
	buffer_seek_begin();
	buffer_write_action(ClientTCP.ReceiveID);
	buffer_write_data(buffer_u64, global.master_id);
	network_send_tcp_packet();
}

f[$ ClientTCP.LeaveLobby] = function(buffer) {
	player_leave_all();
	buffer_seek_begin();
	buffer_write_action(ClientTCP.LobbyList);
	network_send_tcp_packet();
}

f[$ ClientTCP.LobbyList] = function(buffer) {
	with (objFiles) {
		lobby_list = [];
		var lobbies = buffer_read(buffer, buffer_string);
				
		if (lobbies != "null") {
			lobbies = string_split(lobbies, ".");
				
			for (var i = 0; i < array_length(lobbies) - 1; i++) {
				var lobby = lobbies[i];
				var data = string_split(lobby, "|");
				data[1] = (data[1] == "True");
				data[3] = (data[3] == "True");
				var name = data[0];
					
				if (string_length(name) > 8) {
					name = string_copy(name, 1, 8) + "-";
				}
					
				//var text = string_interp("{0}\n\n\n{1}/4", name, data[2]);
				var button = new FileButton(520, 412 + 60 * i, file_width * 2, 64, 1, "", (data[2] == 4 || data[3]) ? c_red : c_white,,, {
					lobby_name: name,
					lobby_password: data[1],
					lobby_clients: data[2]
				});
						
				array_push(lobby_list, button);
				button.name = data[0];
				button.has_password = data[1];
			}
		}
				
		//array_push(lobby_list, new FileButton(520, 412 + 60 * (array_length(lobbies) - 1), file_width * 2, 64, 1, "", c_white,,, {
		//	lobby_name: "TESTAAAA",
		//	lobby_password: false,
		//	lobby_clients: 3
		//}));
				
		//array_push(lobby_list, new FileButton(520, 412 + 60 * (array_length(lobbies) + 0), file_width * 2, 64, 1, "", c_white,,, {
		//	lobby_name: "Hello!",
		//	lobby_password: true,
		//	lobby_clients: 2
		//}));
			
		lobby_return = false;
		online_reading = false;
				
		if (menu_type != 4) {
			menu_type = 4;
			upper_type = menu_type;
			upper_text = "LOBBY DATA";
			lobby_selected = 0;
		}
	}
}

f[$ ClientTCP.LobbyStart] = function(buffer) {
	global.lobby_started = true;
	objFiles.fade_start = true;
	music_stop();
}

f[$ ClientTCP.LobbyKick] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	
	if (global.player_id == player_id) {
		with (objFiles) {
			lobby_leave();
		}
	}
}

f[$ ClientTCP.BoardGameID] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var received_names = buffer_read_array(buffer, buffer_string);
			
	if (check_same_game_id(player_id, received_names)) {
		return;
	}
			
	if (global.player_id == player_id) {
		var names = variable_struct_get_names(global.board_games);
		var send_names = [];
				
		for (var i = 0; i < array_length(names); i++) {
			if (array_contains(received_names, names[i])) {
				array_push(send_names, names[i]);
			}
		}
				
		obtain_same_game_id(send_names);
	}
}

f[$ ClientTCP.BoardPlayerIDs] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var player_ids = buffer_read_array(buffer, buffer_u8);

	if (check_player_game_ids(player_id, player_ids)) {
		return;
	}
			
	if (global.player_id == player_id) {
		obtain_player_game_ids(player_ids);
	}
}

f[$ ClientTCP.ModesAction] = function(buffer) {
	var action = buffer_read(buffer, buffer_string);
	var player_id = buffer_read(buffer, buffer_u8);
			
	switch (room) {
		case rModes: var menu = objModes; break;
		case rParty: case rMinigames: case rTrials: var menu = objMains; break;
	}
		
	with (menu) {
		array_push(network_actions, [action, player_id]);
	}
}

f[$ ClientTCP.BoardRandom] = function(buffer) {
	global.board_selected = buffer_read(buffer, buffer_u8);
}


f[$ ClientTCP.PlayerShoot] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var xx = buffer_read(buffer, buffer_s16);
	var yy = buffer_read(buffer, buffer_s16);
	var spd = buffer_read(buffer, buffer_s8);
	var dir = buffer_read(buffer, buffer_u16);
	var b = instance_create_layer(xx, yy, "Actors", objBullet);
	b.network_id = player_id;
	b.speed = spd;
	b.direction = dir;
}

f[$ ClientTCP.PlayerKill] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
			
	with (focus_player_by_id(player_id)) {
		player_kill(true);
	}
}
#endregion

#region Interactable
f[$ ClientTCP.ShowDice] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var seed = buffer_read(buffer, buffer_u64);
	random_set_seed(seed);
	show_dice(player_id);
}

f[$ ClientTCP.RollDice] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var player_roll = buffer_read(buffer, buffer_u8);
		
	with (objDice) {
		if (network_id == player_id) {
			roll = player_roll + 10;
			roll_dice();
		}
	}
}

f[$ ClientTCP.HideDice] = function(buffer) {
	hide_dice();
}

f[$ ClientTCP.ShowChest] = function(buffer) {
	show_chest();
}

f[$ ClientTCP.OpenChest] = function(buffer) {
	open_chest();
}

f[$ ClientTCP.SpawnChanceTimeBox] = function(buffer) {
	with (objChanceTime) {
		var b = advance_chance_time();
		b.sprites = buffer_read_array(buffer, buffer_u32);
		b.indexes = buffer_read(buffer, buffer_bool);
	}
}

f[$  ClientTCP.SpawnLastTurnsBox] = function(buffer) {
	with (objLastTurns) {
		spawn_last_turns_box();
	}
}
#endregion

#region Interfaces
f[$ ClientTCP.SpawnPlayerInfo] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var turn = buffer_read(buffer, buffer_u8);
	spawn_player_info(player_id, turn);
}

f[$ ClientTCP.Reaction] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var index = buffer_read(buffer, buffer_u8);
	
	with (focus_info_by_id(player_id)) {
		reaction(index);
	}
}

f[$	ClientTCP.ChangeChoiceAlpha] = function(buffer) {
	if (instance_exists(objTurnChoices)) {
		objTurnChoices.alpha_target = buffer_read(buffer, buffer_u8);
	}
}

f[$ ClientTCP.ShowMap] = function(buffer) {
	show_map();
}

f[$ ClientTCP.EndMap] = function(buffer) {
	end_map();
}

f[$ ClientTCP.LessRoll] = function(buffer) {
	var space_x = buffer_read(buffer, buffer_s32);
	var space_y = buffer_read(buffer, buffer_s32);
	global.dice_roll--;
			
	with (objSpaces) {
		space_glow(false);
				
		if (x == space_x && y == space_y) {
			space_glow(true);
		}
	}
}

f[$ ClientTCP.SkipDialogueText] = function(buffer) {
	with (objDialogue) {
		text_display.text.skip();
	}
			
	audio_play_sound(global.sound_cursor_select, 0, false);
}

f[$ ClientTCP.ChangeDialogueText] = function(buffer) {
	var d = objDialogue;
		
	if (!instance_exists(objDialogue) || d.alpha_target == 0) {
		d = start_dialogue([]);
		d.active = false;
		d.endable = false;
	}
		
	with (d) {
		text_display.branches = [];
		var text = buffer_read(buffer, buffer_string);
			
		while (true) {
			var data = buffer_read(buffer, buffer_string);
				
			if (data == "EOA") {
				break;
			}
				
			array_push(text_display.branches, [data, null]);
		}
		
		text_change(text, buffer_read(buffer, buffer_u8));
				
		repeat (array_length(text_display.branches)) {
			array_push(answer_displays, new Text(fntDialogue));
		}
	}
}

f[$ ClientTCP.EndDialogue] = function(buffer) {
	with (objDialogue) {
		endable = true;
		text_end();
	}
}

f[$ ClientTCP.ShowShop] = function(buffer) {
	var s = instance_create_layer(0, 0, "Managers", objShop);
			
	while (true) {
		try {
			array_push(s.stock, global.board_items[buffer_read(buffer, buffer_u8)]);;
		} catch (_) {
			return;
		}
	}
}

f[$ ClientTCP.EndShop] = function(buffer) {
	with (objShop) {
		shop_end();
	}
}

f[$ ClientTCP.ShowBlackhole] = function(buffer) {
	instance_create_layer(0, 0, "Managers", objBlackhole);
}

f[$ ClientTCP.EndBlackhole] = function(buffer) {
	with (objBlackhole) {
		blackhole_end();
	}
}

f[$ ClientTCP.ShowMultipleChoices] = function(buffer) {
	var titles = buffer_read_array(buffer, buffer_string);
	var choices = buffer_read_array(buffer, buffer_string);
	var descriptions = buffer_read_array(buffer, buffer_string);
	var availables = buffer_read_array(buffer, buffer_bool);
	show_multiple_choices(titles, choices, descriptions, availables);
}

f[$ ClientTCP.ChangeMultipleChoiceSelected] = function(buffer) {
	global.choice_selected = buffer_read(buffer, buffer_u8);
	audio_play_sound(global.sound_cursor_move, 0, false);
}

f[$ ClientTCP.EndMultipleChoices] = function(buffer) {
	if (instance_exists(objMultipleChoices)) {
		objMultipleChoices.alpha_target = 0;
	}
}

f[$ ClientTCP.HitChanceTimeBox] = function(buffer) {
	with (objChanceTimeBox) {
		show_sprites[0] = buffer_read(buffer, buffer_u16);
		box_activate();
	}
}

f[$ ClientTCP.HitLastTurnsBox] = function(buffer) {
	with (objLastTurnsBox) {
		show_sprites[0] = buffer_read(buffer, buffer_u16);
		box_activate();
	}
}
#endregion

#region Stats
f[$ ClientTCP.ChangeShines] = function(buffer) {
	var amount = buffer_read(buffer, buffer_s16);
	var type = buffer_read(buffer, buffer_u8);
	var player_id = buffer_read(buffer, buffer_u8);
	change_shines(amount, type, player_id);
}

f[$ ClientTCP.ChangeCoins] = function(buffer) {
	var amount = buffer_read(buffer, buffer_s16);
	var type = buffer_read(buffer, buffer_u8);
	var player_id = buffer_read(buffer, buffer_u8);
	change_coins(amount, type, player_id);
}

f[$ ClientTCP.ChangeItems] = function(buffer) {
	var item_id = buffer_read(buffer, buffer_u8);
	var type = buffer_read(buffer, buffer_u8);
	var player_id = buffer_read(buffer, buffer_u8);
	change_items(global.board_items[item_id], type, player_id);
}

f[$ ClientTCP.ChangeSpace] = function(buffer) {
	var space = buffer_read(buffer, buffer_u8);
	change_space(space);
}
#endregion

#region Events
f[$ ClientTCP.BoardStart] = function(buffer) {
	global.game_id = buffer_read(buffer, buffer_string);
}

f[$ ClientTCP.TurnStart] = function(buffer) {
	turn_start();
}

f[$ ClientTCP.TurnNext] = function(buffer) {
	turn_next();
}

f[$ ClientTCP.ChooseShine] = function(buffer) {
	var space_x = buffer_read(buffer, buffer_s16);
	var space_y = buffer_read(buffer, buffer_s16);
	place_shine(space_x, space_y);
}

f[$ ClientTCP.StartChanceTime] = function(buffer) {
	start_chance_time();
}

f[$ ClientTCP.RepositionChanceTime] = function(buffer) {
	with (objChanceTime) {
		reposition_chance_time();
	}
}

f[$ ClientTCP.EndChanceTime] = function(buffer) {
	with (objChanceTime) {
		rotate_turn = false;
		end_chance_time();
	}
}

f[$ ClientTCP.ChooseMinigame] = function(buffer) {
	choose_minigame();
}

f[$ ClientTCP.StartTheGuy] = function(buffer) {
	start_the_guy();
}

f[$ ClientTCP.ShowTheGuyOptions] = function(buffer) {
	with (objTheGuy) {
		show_the_guy_options();
	}
}

f[$ ClientTCP.EndTheGuy] = function(buffer) {
	with (objTheGuy) {
		rotate_turn = false;
		end_the_guy();
	}
}

f[$ ClientTCP.LastTurnsSayPlayerPlace] = function(buffer) {
	with (objLastTurns) {
		say_player_place();
	}
}

f[$ ClientTCP.LastTurnsHelpLastPlace] = function(buffer) {
	with (objLastTurns) {
		help_last_place();
	}
}

f[$ ClientTCP.LastTurnsEndLastTurns] = function(buffer) {
	with (objLastTurns) {
		end_last_turns();
	}
}

f[$ ClientTCP.BoardHotlandAnnoyingDog] = function(buffer) {
	board_hotland_annoying_dog();
}

f[$ ClientTCP.BoardPalletObtain] = function(buffer) {
	var pokemon = buffer_read(buffer, buffer_u16);
	board_pallet_obtain(pokemon);
}

f[$ ClientTCP.BoardPalletBattle] = function(buffer) {
	var pokemon = buffer_read(buffer, buffer_u16);
	board_pallet_battle(pokemon);
}

f[$ ClientTCP.BoardDreamsTeleports] = function(buffer) {
	var reference = buffer_read(buffer, buffer_u8);
	board_dreams_teleports(reference);
}

f[$ ClientTCP.BoardNsanityReturn] = function(buffer) {
	board_nsanity_return();
}
#endregion

#region Animations
f[$ ClientTCP.ItemApplied] = function(buffer) {
	var item_id = buffer_read(buffer, buffer_u8);
	item_applied(global.board_items[item_id]);
}

f[$ ClientTCP.ItemAnimation] = function(buffer) {
	var item_id = buffer_read(buffer, buffer_u8);
	var additional = buffer_read(buffer, buffer_s8);
	item_animation(item_id, additional);
}

f[$ ClientTCP.StartBlackholeSteal] = function(buffer) {
	with (objItemBlackholeAnimation) {
		start_blackhole_steal();
	}
}

f[$ ClientTCP.EndBlackholeSteal] = function(buffer) {
	with (objItemBlackholeAnimation) {
		steal_count = buffer_read(buffer, buffer_u8);
		end_blackhole_steal();
	}
}
#endregion

#region Minigames
f[$ ClientTCP.MinigameOverviewStart] = function(buffer) {
	var set = buffer_read(buffer, buffer_u8);
		
	with (objMinigameOverview) {
		start_minigame(set);
	}
}

f[$ ClientTCP.MinigameFinish] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var timer = buffer_read(buffer, buffer_s32);
	var points = buffer_read(buffer, buffer_s32);
	var shines = buffer_read(buffer, buffer_u16);
	var coins = buffer_read(buffer, buffer_u16);
	var signal = buffer_read(buffer, buffer_bool);
	var info = global.minigame_info;
	var scoring = info.player_scores[player_id - 1];
	scoring.ready = true;
	scoring.timer = timer;
	scoring.points = points;
	var player_info = player_info_by_id(player_id);
	player_info.shines = shines;
	player_info.coins = coins;
			
	if (info.is_finished || signal) {
		minigame_finish();
	}
}

#region 4vs
f[$ ClientTCP.Minigame4vs_Lead_Input] = function(buffer) {
	with (objMinigameController) {
		var player_id = buffer_read(buffer, buffer_u8);
		var input_id = buffer_read(buffer, buffer_u8);
				
		array_push(network_inputs, {
			input_player_id: player_id,
			input_input_id: input_id
		});
				
		if (alarm_is_stopped(9)) {
			alarm_frames(9, 1);
		}
	}
}

f[$ ClientTCP.Minigame4vs_Haunted_Boo] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
			
	with (objMinigame4vs_Haunted_Boo) {
		if (!array_contains(player_targets, player_id)) {
			array_push(player_targets, player_id);
		}
	}
}

f[$ ClientTCP.Minigame4vs_Magic_Hold] = function(buffer) {
	var player_turn = buffer_read(buffer, buffer_u8);
	var order = buffer_read(buffer, buffer_s8);
			
	with (objMinigame4vs_Magic_Items) {
		if (self.order == order && self.player_turn == player_turn) {
			hold_item(false);
			break;
		}
	}
}

f[$ ClientTCP.Minigame4vs_Magic_Release] = function(buffer) {
	var player_turn = buffer_read(buffer, buffer_u8);
	var order = buffer_read(buffer, buffer_s8);
	var item_x = buffer_read(buffer, buffer_s32);
	var item_y = buffer_read(buffer, buffer_s32);
			
	with (objMinigame4vs_Magic_Items) {
		if (self.order == order && self.player_turn == player_turn) {
			x = item_x;
			y = item_y;
			release_item(false, false);
			break;
		}
	}
}

f[$ ClientTCP.Minigame4vs_Magic_CurtainSwitch] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
			
	with (objMinigame4vs_Magic_Curtain) {
		if (player.network_id == player_id) {
			curtain_switch(false);
			break;
		}
	}
}

f[$ ClientTCP.Minigame4vs_Mansion_Door] = function(buffer) {
	var row = buffer_read(buffer, buffer_u8);
	var col = buffer_read(buffer, buffer_u8);
			
	with (objMinigame4vs_Mansion_Door) {
		if (self.row == row && self.col == col) {
			open_door(false);
			break;
		}
	}
}

f[$ ClientTCP.Minigame4vs_Painting_Platform] = function(buffer) {
	var platform_x = buffer_read(buffer, buffer_s32);
	var platform_y = buffer_read(buffer, buffer_s32);
	var new_id = buffer_read(buffer, buffer_u8);
			
	with (objMinigame4vs_Painting_Platform) {
		if (x == platform_x && y == platform_y) {
			platform_paint(new_id, false);
			break;
		}
	}
}

f[$ ClientTCP.Minigame4vs_Bugs_Counting] = function(buffer) {
	var player_turn = buffer_read(buffer, buffer_u8);
	var count = buffer_read(buffer, buffer_u8);
			
	with (objMinigame4vs_Bugs_Counting) {
		if (self.player_turn == player_turn) {
			self.count = count;
			break;
		}
	}
}

f[$ ClientTCP.Minigame4vs_Blocks_BlockDestabilize] = function(buffer) {
	var block_x = buffer_read(buffer, buffer_s32);
	var block_y = buffer_read(buffer, buffer_s32);
	
	with (objMinigame4vs_Blocks_Block) {
		if (x == block_x && y == block_y) {
			block_destabilize(false);
		}
	}
}

f[$ ClientTCP.Minigame4vs_Chests_ChestSelected] = function(buffer) {
	var n = buffer_read(buffer, buffer_u8);
	var selected = buffer_read(buffer, buffer_u8);
			
	with (objMinigame4vs_Chests_Chest) {
		if (self.n == n) {
			if (self.selected == -1) {
				self.selected = selected;
				target_y = ystart - 32;
			} else if (self.selected != selected) {
				focus_player_by_id(self.selected).frozen = false;
				self.selected = -1;
				target_y = ystart;
			}
		}
	}
			
	with (objMinigame4vs_Chests_Chest) {
		if (self.n != n && self.selected == selected) {
			focus_player_by_id(self.selected).frozen = false;
			self.selected = -1;
			target_y = ystart;
		}
	}
}

f[$ ClientTCP.Minigame4vs_Slime_BlockEntrance] = function(buffer) {
	with (objMinigameController) {
		block_entrance(false);
	}
}

f[$ ClientTCP.Minigame4vs_Slime_SlimeShot] = function(buffer) {
	with (objMinigame4vs_Slime_Slime) {
		slime_shot(false);
	}
}

f[$ ClientTCP.Minigame4vs_Dizzy_GrabCoin] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var coin_x = buffer_read(buffer, buffer_s32);
	var coin_y = buffer_read(buffer, buffer_s32);
			
	with (objMinigame4vs_Dizzy_Coin) {
		if (x == coin_x && y == coin_y) {
			grab_coin(player_id, false);
		}
	}
}

f[$ ClientTCP.Minigame4vs_Targets_DestroyTarget] = function(buffer) {
	var target_xstart = buffer_read(buffer, buffer_s32);
	var target_ystart = buffer_read(buffer, buffer_s32);
	var target_num = buffer_read(buffer, buffer_u8);
			
	with (objMinigame4vs_Targets_Target) {
		if (xstart == target_xstart && ystart == target_ystart && num == target_num) {
			destroy_target(false);
			break;
		}
	}
}

f[$ ClientTCP.Minigame4vs_Bullets_Stop] = function(buffer) {
	var stop_index = buffer_read(buffer, buffer_u8);
	var stop_scale = buffer_read(buffer, buffer_u8);
		
	with (objMinigame4vs_Bullets_Block) {
		image_index = stop_index;
		scale = stop_scale;
		stop(false);
	}
}

f[$ ClientTCP.Minigame4vs_Drawn_CollectKey] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var key_x = buffer_read(buffer, buffer_s32);
	var key_y = buffer_read(buffer, buffer_s32);
			
	with (objMinigame4vs_Drawn_Key) {
		if (x == key_x && y == key_y) {
			collect_key(player_id, false);
			break;
		}
	}
}

f[$ ClientTCP.Minigame4vs_Bubble_Goal] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	minigame4vs_points(player_id, 1);
}

f[$ ClientTCP.Minigame4vs_Sky_Points] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var points = buffer_read(buffer, buffer_s8);
	minigame4vs_points(player_id, points);
}

f[$ ClientTCP.Minigame4vs_Golf_GivePoints] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var points = buffer_read(buffer, buffer_u16);
	
	with (objMinigameController) {
		give_points(player_id, points, false);
	}
}

f[$ ClientTCP.Minigame4vs_Jingle_SledgeShoot] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	
	with (objMinigame4vs_Jingle_Sledge) {
		if (self.player_id == player_id) {
			sledge_shoot(false);
			break;
		}
	}
}

f[$ ClientTCP.Minigame4vs_Jingle_SledgeJump] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	
	with (objMinigame4vs_Jingle_Sledge) {
		if (self.player_id == player_id) {
			sledge_jump(false);
			break;
		}
	}
}

f[$ ClientTCP.Minigame4vs_Jingle_SledgeHit] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	
	with (objMinigame4vs_Jingle_Sledge) {
		if (self.player_id == player_id) {
			sledge_hit(false);
			break;
		}
	}
}
#endregion

#region 1vs3
f[$ ClientTCP.Minigame1vs3_Avoid_Block] = function(buffer) {
	var attack = buffer_read(buffer, buffer_u8);
			
	with (objMinigame1vs3_Avoid_Block) {
		if (image_index == attack) {
			activate(attack, true);
			break;
		}
	}
}

f[$ ClientTCP.Minigame1vs3_Conveyor_Switch] = function(buffer) {
	var image = buffer_read(buffer, buffer_u8);
			
	with (objMinigame1vs3_Conveyor_Switch) {
		if (image_index == image) {
			activate(image, true);
			break;
		}
	}
}

f[$ ClientTCP.Minigame1vs3_Showdown_Block] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var number = buffer_read(buffer, buffer_u8);
			
	with (objMinigame1vs3_Showdown_Block) {
		if (self.player_id == player_id) {
			self.number = number;
			break;
		}
	}
			
	with (objMinigame1vs3_Showdown_Block) {
		if (self.number == -1) {
			return;
		}
	}
			
	with (objMinigameController) {
		alarm_call(4, 1);
	}
}

f[$ ClientTCP.Minigame1vs3_Coins_Coin] = function(buffer) {
	if (objMinigameController.info.is_finished) {
		return;
	}
			
	var player_id = buffer_read(buffer, buffer_u8);
	minigame4vs_points(player_id, 1);
}

f[$ ClientTCP.Minigame1vs3_Race_Solo] = function(buffer) {
	var action = buffer_read(buffer, buffer_string);
	array_push(objMinigame1vs3_Race_Controller.network_solo_actions, action);
}

f[$ ClientTCP.Minigame1vs3_Race_Team] = function(buffer) {
	var action = buffer_read(buffer, buffer_string);
	array_push(objMinigame1vs3_Race_Controller.network_team_actions, action);
}

f[$ ClientTCP.Minigame1vs3_Warping_Push] = function(buffer) {
	var push_x = buffer_read(buffer, buffer_s32);
			
	with (objMinigame1vs3_Warping_Push) {
		x = push_x;
	}
}

f[$ ClientTCP.Minigame1vs3_Warping_Warp] = function(buffer) {
	var warp_x = buffer_read(buffer, buffer_s32);
	var warp_y = buffer_read(buffer, buffer_s32);
			
	with (objMinigameController) {
		create_warp(warp_x, warp_y);
	}
}

f[$ ClientTCP.Minigame1vs3_Hunt_ReticleShoot] = function(buffer) {
	var reticle_x = buffer_read(buffer, buffer_s32);
	var reticle_y = buffer_read(buffer, buffer_s32);
			
	with (objMinigameController) {
		create_shoot(reticle_x, reticle_y);
	}
}

f[$ ClientTCP.Minigame1vs3_Hunt_ReticleMove] = function(buffer) {
	var index = buffer_read(buffer, buffer_u8);
	var reticle_x = buffer_read(buffer, buffer_s32);
	var reticle_y = buffer_read(buffer, buffer_s32);
			
	with (objMinigame1vs3_Hunt_Reticle) {
		if (self.index == index) {
			x = reticle_x;
			y = reticle_y;
			break;
		}
	}
}

f[$ ClientTCP.Minigame1vs3_Aiming_LaserShoot] = function(buffer) {
	var laser_x = buffer_read(buffer, buffer_s32);
	var laser_y = buffer_read(buffer, buffer_s32);
			
	with (objMinigameController) {
		create_laser(laser_x, laser_y);
	}
}

f[$ ClientTCP.Minigame1vs3_Aiming_DestroyBlock] = function(buffer) {
	var block_is_player = buffer_read(buffer, buffer_bool);
	var block_player_num = buffer_read(buffer, buffer_u8);
		
	with (objMinigame1vs3_Aiming_Block) {
		if (is_player == block_is_player && player_num == block_player_num) {
			if (is_player) {
				minigame1vs3_team(player_num).lost = true;
			}

			instance_destroy();
		}
	}
}

f[$ ClientTCP.Minigame1vs3_Host_SetPickDoor] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var pick_id = buffer_read(buffer, buffer_u64);
		
	with (objMinigameController) {
		set_pick_door(focus_player_by_id(player_id), pick_id, false);
	}
}

f[$ ClientTCP.Minigame1vs3_House_CherryMove] = function(buffer) {
	var move = buffer_read(buffer, buffer_s8);
	
	with (objMinigameController) {
		cherry_move(move, false);
	}
}

f[$ ClientTCP.Minigame1vs3_House_CherryJump] = function(buffer) {
	with (objMinigameController) {
		cherry_jump(false);
	}
}
#endregion

#region 2vs2
f[$ ClientTCP.Minigame2vs2_Maze_Item] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var item_x = buffer_read(buffer, buffer_s16);
	var item_y = buffer_read(buffer, buffer_s16);
			
	with (objMinigame2vs2_Maze_Item) {
		if (x == item_x && y == item_y) {
			collect_item(focus_player_by_id(player_id));
		}
	}
}

f[$ ClientTCP.Minigame2vs2_Fruits_Fruit] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var points = buffer_read(buffer, buffer_s8);
	minigame4vs_points(player_id, points);
}

f[$ ClientTCP.Minigame2vs2_Buttons_Button] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var is_inside = buffer_read(buffer, buffer_bool);
	var outside_current = buffer_read(buffer, buffer_u8);
	var inside_current = buffer_read(buffer, buffer_u8);
			
	if (!is_inside) {
		objMinigameController.buttons_outside_current = outside_current;
	} else {
		objMinigameController.buttons_inside_current = inside_current;
	}
			
	with (objMinigame2vs2_Buttons_Button) {
		if (inside == is_inside) {
			press_button(player_id);
		}
	}
}

f[$ ClientTCP.Minigame2vs2_Colorful_PatternMoveVertical] = function(buffer) {
	var pattern_x = buffer_read(buffer, buffer_u16);
	var pattern_round = buffer_read(buffer, buffer_u8);
	var index = buffer_read(buffer, buffer_u8);
	var row_selected = buffer_read(buffer, buffer_u8);
			
	with (objMinigame2vs2_Colorful_Patterns) {
		if (x == pattern_x && self.pattern_round == pattern_round) {
			pattern_move_vertical(index, row_selected, false);
			break;
		}
	}
}

f[$ ClientTCP.Minigame2vs2_Colorful_PatternMoveHorizontal] = function(buffer) {
	var pattern_x = buffer_read(buffer, buffer_u16);
	var pattern_round = buffer_read(buffer, buffer_u8);
	var index = buffer_read(buffer, buffer_u8);
	var col_selected = buffer_read(buffer, buffer_u8);
			
	with (objMinigame2vs2_Colorful_Patterns) {
		if (x == pattern_x && self.pattern_round == pattern_round) {
			pattern_move_horizontal(index, col_selected, false);
			break;
		}
	}
}

f[$ ClientTCP.Minigame2vs2_Colorful_PatternSelect] = function(buffer) {
	var pattern_x = buffer_read(buffer, buffer_u16);
	var pattern_round = buffer_read(buffer, buffer_u8);
	var index = buffer_read(buffer, buffer_u8);
			
	with (objMinigame2vs2_Colorful_Patterns) {
		if (x == pattern_x && self.pattern_round == pattern_round) {
			pattern_select(index, false);
			break;
		}
	}
}

f[$ ClientTCP.Minigame2vs2_Duos_Button] = function(buffer) {
	var trg = buffer_read(buffer, buffer_u8);
			
	with (objMinigame2vs2_Duos_Button) {
		if (self.trg == trg) {
			press_button(false);
		}
	}
}

f[$ ClientTCP.Minigame2vs2_Duel_Shot] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var shot_time = buffer_read(buffer, buffer_u16);
	objMinigameController.player_shot_time[player_id - 1] = shot_time;
}

f[$ ClientTCP.Minigame2vs2_Soccer_Goal] = function(buffer) {
	var ball_x = buffer_read(buffer, buffer_s32);
	var ball_y = buffer_read(buffer, buffer_s32);
			
	with (objMinigame2vs2_Soccer_Ball) {
		x = ball_x;
		y = ball_y;
		soccer_goal(false);
	}
}

f[$ ClientTCP.Minigame2vs2_Idol_WhacIdol] = function(buffer) {
	var hole_x = buffer_read(buffer, buffer_s32);
	var hole_y = buffer_read(buffer, buffer_s32);
	var player_id = buffer_read(buffer, buffer_u8);
	
	with (objMinigame2vs2_Idol_Hole) {
		if (x == hole_x && y == hole_y) {
			whac_idol(player_id, false);
			break;
		}
	}
}
#endregion
#endregion

#region Results
f[$ ClientTCP.ResultsBonus] = function(buffer) {
	var player_turn = buffer_read(buffer, buffer_u8);
	var player_shines = buffer_read(buffer, buffer_u16);
	var player_coins = buffer_read(buffer, buffer_u16);
	var player_info = player_info_by_turn(player_turn);
	player_info.shines = player_shines;
	player_info.coins = player_coins;
	var scores_scores = buffer_read_array(buffer, buffer_u16);
			
	for (var i = 0; i < array_length(global.bonus_shines); i++) {
		global.bonus_shines[i].scores[player_turn - 1] = scores_scores[i];
	}
			
	global.bonus_shines_ready[player_turn - 1] = true;
		
	with (objResults) {
		results_bonus();
	}
}

f[$ ClientTCP.ResultsBonusShineGoUp] = function(buffer) {
	with (objResultsBonusShine) {
		go_up();
	}
}

f[$ ClientTCP.ResultsBonusShineNextBonus] = function(buffer) {
	with (objResultsBonusShine) {
		next_bonus();
	}
}

f[$ ClientTCP.ResultsWon] = function(buffer) {
	with (objResults) {
		results_won();
	}
}

f[$ ClientTCP.ResultsEnd] = function(buffer) {
	with (objResults) {
		results_end();
	}
}

f[$ ClientTCP.ResultsProceed] = function(buffer) {
	with (objResults) {
		results_proceed();
	}
}
#endregion
#endregion

#region UDP
enum ClientUDP {
	#region Networking
	Initialize,
	Heartbeat,
	LobbyStart,
	PlayerData,
	PlayerJump,
	#endregion
	
	#region Interfaces
	MapLook,
	ChangeChoiceSelected,
	ChangeDialogueAnswer,
	ChangeShopSelected,
	ChangeBlackholeSelected,
	#endregion
	
	#region Events
	CrushTheGuy,
	NoNoTheGuy,
	#endregion
	
	#region Minigames
	#region 1vs3
	Minigame1vs3_Aiming_Block,
	#endregion
	
	#region 2vs2
	Minigame2vs2_Squares_Halfs,
	Minigame2vs2_Soccer_Ball
	#endregion
	#endregion
}

global.udp_functions = {};
var f = global.udp_functions;

#region Networking
f[$ ClientUDP.Initialize] = function(buffer) {
	global.udp_ready = true;
			
	with (objNetworkClient) {
		alarm_stop(1);
	}
			
	buffer_seek_begin();
	buffer_write_action(ClientTCP.LobbyList);
	network_send_tcp_packet();
}

f[$ ClientUDP.Heartbeat] = function(buffer) {
	if (IS_ONLINE) {
		with (objNetworkClient) {
			alarm_call(0, 9);
		}
	}
}

f[$ ClientUDP.LobbyStart] = function(buffer) {
	music_fade();
	audio_play_sound(global.sound_cursor_big_select, 0, false);
}

f[$ ClientUDP.PlayerData] = function(buffer) {
	player_read_data(buffer);
}

f[$ ClientUDP.PlayerJump] = function(buffer) {
	var sound = buffer_read(buffer, buffer_u32);
	audio_play_sound(sound, 0, false);
}
#endregion

#region Interfaces
f[$ ClientUDP.MapLook] = function(buffer) {
	var look_x = buffer_read(buffer, buffer_f32);
	var look_y = buffer_read(buffer, buffer_f32);
			
	with (objMapLook) {
		self.look_x = look_x;
		self.look_y = look_y;
	}
}

f[$ ClientUDP.ChangeChoiceSelected] = function(buffer) {
	if (room != rMinigameOverview) {
		if (instance_exists(objTurnChoices)) {
			objTurnChoices.option_selected = buffer_read(buffer, buffer_u8);
			audio_play_sound(global.sound_cursor_move, 0, false);
		}
	} else {
		if (instance_exists(objMinigameOverview)) {
			objMinigameOverview.option_selected = buffer_read(buffer, buffer_u8);
			audio_play_sound(global.sound_cursor_move, 0, false);
		}
	}
}

f[$ ClientUDP.ChangeDialogueAnswer] = function(buffer) {
	if (instance_exists(objDialogue)) {
		var answer_index = buffer_read(buffer, buffer_u8);
		objDialogue.answer_index = answer_index;
		audio_play_sound(global.sound_cursor_select, 0, false);
	}
}

f[$ ClientUDP.ChangeShopSelected] = function(buffer) {
	if (instance_exists(objShop)) {
		objShop.option_selected = buffer_read(buffer, buffer_u8);
		audio_play_sound(global.sound_cursor_select, 0, false);
	}
}

f[$ ClientUDP.ChangeBlackholeSelected] = function(buffer) {
	if (instance_exists(objBlackhole)) {
		objBlackhole.option_selected = buffer_read(buffer, buffer_u8);
		audio_play_sound(global.sound_cursor_select, 0, false);
	}
}
#endregion

#region Events
f[$ ClientUDP.CrushTheGuy] = function(buffer) {
	with (objTheGuy) {
		alarm_frames(5, 1);
	}
}

f[$ ClientUDP.NoNoTheGuy] = function(buffer) {
	with (objTheGuy) {
		nono_the_guy();
	}
}
#endregion

#region Minigames
#region 1vs3
f[$ ClientUDP.Minigame1vs3_Aiming_Block] = function(buffer) {
	var block_is_player = buffer_read(buffer, buffer_bool);
	var block_player_num = buffer_read(buffer, buffer_u8);
	var block_x = buffer_read(buffer, buffer_s32);
	var block_y = buffer_read(buffer, buffer_s32);
			
	with (objMinigame1vs3_Aiming_Block) {
		if (is_player == block_is_player && player_num == block_player_num) {
			x = block_x;
			y = block_y;
			break;
		}
	}
}
#endregion

#region 2vs2
f[$ ClientUDP.Minigame2vs2_Squares_Halfs] = function(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
		var angle = buffer_read(buffer, buffer_u16);
			
		with (objMinigame2vs2_Squares_Halfs) {
			if (!done && network_id == player_id) {
				image_angle = angle;
				break;
			}
		}
}

f[$ ClientUDP.Minigame2vs2_Soccer_Ball] = function(buffer) {
	var ball_x = buffer_read(buffer, buffer_s32);
	var ball_y = buffer_read(buffer, buffer_s32);
	var ball_hspeed = buffer_read(buffer, buffer_f16);
	var ball_vspeed = buffer_read(buffer, buffer_f16);
	var ball_gravity = buffer_read(buffer, buffer_f16);
			
	with (objMinigame2vs2_Soccer_Ball) {
		x = ball_x;
		y = ball_y;
		hspeed = ball_hspeed;
		vspeed = ball_vspeed;
		gravity = ball_gravity;
	}
}
#endregion
#endregion
#endregion

function network_read_client(ip, port, buffer) {
	if (buffer_get_size(buffer) == 0) {
		print("Received empty buffer.");
		return;
	}
	
	buffer_seek_begin(buffer);
	
	try {
		var match_id = buffer_read(buffer, buffer_u8);
	
		if (match_id != FAILCHECK_ID) {
			print("Failcheck ID doesn't match.\nGot: " + string(match_id) + "\nExpected: " + string(FAILCHECK_ID));
			return;
		}
		
		var match_size = buffer_read(buffer, buffer_u16);
	
		if (buffer_get_size(buffer) != match_size) {
			print("Buffer size doesn't match.\nGot: " + string(buffer_get_size(buffer)) + "\nExpected: " + string(match_size));
		}
		
		var is_tcp = buffer_read(buffer, buffer_bool);
		var data_id = buffer_read(buffer, buffer_u16);
	} catch (_) {
		print("Unexpected error when reading buffer header.");
		return;
	}
	
	if (is_tcp) {
		global.tcp_functions[$ data_id](buffer);
	} else {
		global.udp_functions[$ data_id](buffer);
	}
}