enum ClientTCP {
	//Network
	ReceiveMasterID,
	ReceiveID,
	PlayerConnect,
	PlayerDisconnect,
	CreateLobby,
	JoinLobby,
	LeaveLobby,
	LobbyList,
	LobbyStart,
	BoardGameID,
	BoardPlayerIDs,
	PartyAction,
	MinigameMode,
	PlayerKill,
	
	//Interactables
	ShowDice,
	RollDice,
	HideDice,
	ShowChest,
	OpenChest,
	SpawnChanceTimeBox,
	SpawnLastTurnsBox,
	
	//Interfaces
	SpawnPlayerInfo,
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
	
	//Stats
	ChangeShines,
	ChangeCoins,
	ChangeItems,
	ChangeSpace,
	
	//Events
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
	
	//Animations
	ItemApplied,
	ItemAnimation,
	StartBlackholeSteal,
	EndBlackholeSteal,
	
	//Minigames
	MinigameOverviewStart,
	MinigameFinish,
	Minigame4vs_Lead_Input,
	Minigame4vs_Haunted_Boo,
	Minigame4vs_Magic_Hold,
	Minigame4vs_Magic_Release,
	Minigame4vs_Mansion_Door,
	Minigame4vs_Painting_Platform,
	Minigame2vs2_Buttons_Button,
	Minigame1vs3_Avoid_Block,
	Minigame1vs3_Conveyor_Switch,
	Minigame1vs3_Showdown_Block,
	Minigame1vs3_Coins_Coin,
	Minigame1vs3_Coins_HoldSpike,
	Minigame1vs3_Coins_ThrowSpike,
	Minigame1vs3_Chase_Solo,
	Minigame1vs3_Chase_Team,
	Minigame2vs2_Maze_Item,
	Minigame2vs2_Fruits_Fruit,
	Minigame2vs2_Colorful_PatternMoveVertical,
	Minigame2vs2_Colorful_PatternMoveHorizontal,
	Minigame2vs2_Colorful_PatternSelect,
	
	//Results
	ResultsCoins,
	ResultsBonus,
	ResultsBonusShineGoUp,
	ResultsBonusShineNextBonus,
	ResultsWon,
	ResultsEnd,
	ResultsProceed
}

enum ClientUDP {
	//Networking
	Initialize,
	Heartbeat,
	LobbyStart,
	PlayerData,
	PlayerShoot,
	
	//Interfaces
	MapLook,
	ChangeChoiceSelected,
	ChangeDialogueAnswer,
	ChangeShopSelected,
	ChangeBlackholeSelected,
	
	//Events
	CrushTheGuy,
	NoNoTheGuy,
	
	//Minigames
	Minigame2vs2_Squares_Halfs
}

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
		network_read_client_tcp(ip, port, buffer, data_id);
	} else {
		network_read_client_udp(buffer, data_id);
	}
}

function network_read_client_tcp(ip, port, buffer, data_id) {
	switch (data_id) {
		#region Network
		case ClientTCP.ReceiveMasterID:
			global.master_id = buffer_read(buffer, buffer_u64);
			objNetworkClient.alarm[1] = 1;
			break;
		
		case ClientTCP.ReceiveID:
			global.player_id = buffer_read(buffer, buffer_u8);
			player_join_all();
			
			with (objFiles) {
				online_reading = false;
				menu_type = 5;
				upper_type = menu_type;
				upper_text = lobby_texts[0];
			}
			break;
			
		case ClientTCP.PlayerConnect:
			var player_id = buffer_read(buffer, buffer_u8);
			player_join(player_id);
			break;
				
		case ClientTCP.PlayerDisconnect:
			var player_id = buffer_read(buffer, buffer_u8);
			player_disconnection(player_id);
			break;
			
		case ClientTCP.CreateLobby:
			var same_name = buffer_read(buffer, buffer_bool);
			objFiles.online_reading = false;
			
			if (same_name) {
				popup("A lobby with that name already exists!");
				return;
			}
		
			buffer_seek_begin();
			buffer_write_action(ClientTCP.ReceiveID);
			buffer_write_data(buffer_u64, global.master_id);
			network_send_tcp_packet();
			break;
			
		case ClientTCP.JoinLobby:
			var state = buffer_read(buffer, buffer_u8);
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
			break;
			
		case ClientTCP.LeaveLobby:
			player_leave_all();
			buffer_seek_begin();
			buffer_write_action(ClientTCP.LobbyList);
			network_send_tcp_packet();
			break;
			
		case ClientTCP.LobbyList:
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
					
						if (string_length(name) > 5) {
							name = string_copy(name, 1, 5) + "-";
						}
					
						var text = string_interp("{0}\n\n\n{1}/4", name, data[2]);
						var button = new FileButton(550, 402, file_width, 160, 1, text, (data[2] == 4 || data[3]) ? c_red : c_white,, (data[1]) ? sprFilesLock : null);
						array_push(lobby_list, button);
						button.name = data[0];
						button.has_password = data[1];
					}
				}
				
				//array_push(lobby_list, new FileButton(550, 402, 192, 160, 1, "WWWWWWWW\n\n\n1/4", c_white,, sprFilesLock));
				//array_push(lobby_list, new FileButton(550, 402, 192, 160, 1, "NAME1\n\n\n1/4", c_white,, sprFilesLock));
				//array_push(lobby_list, new FileButton(550, 402, 192, 160, 1, "NAME2\n\n\n1/4", c_white,, sprFilesLock));
				//array_push(lobby_list, new FileButton(550, 402, 192, 160, 1, "AAAAAAAA\n\n\n1/4", c_white,, sprFilesLock));
				//array_push(lobby_list, new FileButton(550, 402, 192, 160, 1, "NAME3\n\n\n1/4", c_white,, sprFilesLock));
				//array_push(lobby_list, new FileButton(550, 402, 192, 160, 1, "NAME4\n\n\n1/4", c_white,, sprFilesLock));
			
				lobby_return = false;
				online_reading = false;
				menu_type = 4;
				upper_type = menu_type;
				upper_text = "LOBBY DATA";
			}
			break;
			
		case ClientTCP.LobbyStart:
			global.lobby_started = true;
			objFiles.fade_start = true;
			music_stop();
			break;
			
		case ClientTCP.BoardGameID:
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
			break;
			
		case ClientTCP.BoardPlayerIDs:
			var player_id = buffer_read(buffer, buffer_u8);
			var player_ids = buffer_read_array(buffer, buffer_u8);

			if (check_player_game_ids(player_id, player_ids)) {
				return;
			}
			
			if (global.player_id == player_id) {
				obtain_player_game_ids(player_ids);
			}
			break;
			
		case ClientTCP.PartyAction:
			var action = buffer_read(buffer, buffer_string);
			var player_id = buffer_read(buffer, buffer_u8);
			
			switch (room) {
				case rModes: var menu = objModes; break;
				case rParty: case rMinigames: var menu = objPartyMinigames; break;
				case rSkins: var menu = objSkins; break;
				case rTrophies: var menu = objTrophies; break;
			}
		
			with (menu) {
				array_push(network_actions, [action, player_id]);
			}
			break;
			
		case ClientTCP.MinigameMode:
			global.seed_bag = buffer_read_array(buffer, buffer_u64);
			break;
			
		case ClientTCP.PlayerKill:
			var player_id = buffer_read(buffer, buffer_u8);
			
			with (focus_player_by_id(player_id)) {
				player_kill(true);
			}
			break;
		#endregion
			
		#region Interactable
		case ClientTCP.ShowDice:
			var player_id = buffer_read(buffer, buffer_u8);
			var seed = buffer_read(buffer, buffer_u64);
			random_set_seed(seed);
			show_dice(player_id);
			break;
			
		case ClientTCP.RollDice:
			var player_id = buffer_read(buffer, buffer_u8);
			var player_roll = buffer_read(buffer, buffer_u8);
		
			with (objDice) {
				if (network_id == player_id) {
					roll = player_roll + 10;
					roll_dice();
				}
			}
			break;
			
		case ClientTCP.HideDice:
			hide_dice();
			break;
			
		case ClientTCP.ShowChest:
			show_chest();
			break;
			
		case ClientTCP.OpenChest:
			open_chest();
			break;
			
		case ClientTCP.SpawnChanceTimeBox:
			with (objChanceTime) {
				var b = advance_chance_time();
				b.sprites = buffer_read_array(buffer, buffer_u32);
				b.indexes = buffer_read(buffer, buffer_bool);
			}
			break;
			
		case ClientTCP.SpawnLastTurnsBox:
			with (objLastTurns) {
				spawn_last_turns_box();
			}
			break;
		#endregion
			
		#region Interfaces
		case ClientTCP.SpawnPlayerInfo:
			var player_id = buffer_read(buffer, buffer_u8);
			var turn = buffer_read(buffer, buffer_u8);
			spawn_player_info(player_id, turn);
			break;
		
		case ClientTCP.ChangeChoiceAlpha:
			if (instance_exists(objTurnChoices)) {
				objTurnChoices.alpha_target = buffer_read(buffer, buffer_u8);
			}
			break;
			
		case ClientTCP.ShowMap:
			show_map();
			break;
			
		case ClientTCP.EndMap:
			end_map();
			break;
		
		case ClientTCP.LessRoll:
			var space_x = buffer_read(buffer, buffer_s32);
			var space_y = buffer_read(buffer, buffer_s32);
			global.dice_roll--;
			
			with (objSpaces) {
				space_glow(false);
				
				if (x == space_x && y == space_y) {
					space_glow(true);
				}
			}
			break;
			
		case ClientTCP.SkipDialogueText:
			with (objDialogue) {
				text_display.text.skip();
			}
			
			audio_play_sound(global.sound_cursor_select, 0, false);
			break;
			
		case ClientTCP.ChangeDialogueText:
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
			break;
			
		case ClientTCP.EndDialogue:
			with (objDialogue) {
				endable = true;
				text_end();
			}
			break;
			
		case ClientTCP.ShowShop:
			var s = instance_create_layer(0, 0, "Managers", objShop);
			
			while (true) {
				try {
					array_push(s.stock, global.board_items[buffer_read(buffer, buffer_u8)]);;
				} catch (_) {
					return;
				}
			}
			break;
			
		case ClientTCP.EndShop:
			with (objShop) {
				shop_end();
			}
			break;
			
		case ClientTCP.ShowBlackhole:
			instance_create_layer(0, 0, "Managers", objBlackhole);
			break;
			
		case ClientTCP.EndBlackhole:
			with (objBlackhole) {
				blackhole_end();
			}
			break;
			
		case ClientTCP.ShowMultipleChoices:
			var titles = buffer_read_array(buffer, buffer_string);
			var choices = buffer_read_array(buffer, buffer_string);
			var descriptions = buffer_read_array(buffer, buffer_string);
			var availables = buffer_read_array(buffer, buffer_bool);
			show_multiple_choices(titles, choices, descriptions, availables);
			break;
			
		case ClientTCP.ChangeMultipleChoiceSelected:
			global.choice_selected = buffer_read(buffer, buffer_u8);
			audio_play_sound(global.sound_cursor_move, 0, false);
			break;
			
		case ClientTCP.EndMultipleChoices:
			if (instance_exists(objMultipleChoices)) {
				objMultipleChoices.alpha_target = 0;
			}
			break;
			
		case ClientTCP.HitChanceTimeBox:
			with (objChanceTimeBox) {
				show_sprites[0] = buffer_read(buffer, buffer_u16);
				box_activate();
			}
			break;
			
		case ClientTCP.HitLastTurnsBox:
			with (objLastTurnsBox) {
				show_sprites[0] = buffer_read(buffer, buffer_u16);
				box_activate();
			}
			break;
		#endregion
			
		#region Stats
		case ClientTCP.ChangeShines:
			var amount = buffer_read(buffer, buffer_s16);
			var type = buffer_read(buffer, buffer_u8);
			var player_id = buffer_read(buffer, buffer_u8);
			change_shines(amount, type, player_id);
			break;
			
		case ClientTCP.ChangeCoins:
			var amount = buffer_read(buffer, buffer_s16);
			var type = buffer_read(buffer, buffer_u8);
			var player_id = buffer_read(buffer, buffer_u8);
			change_coins(amount, type, player_id);
			break;
			
		case ClientTCP.ChangeItems:
			var item_id = buffer_read(buffer, buffer_u8);
			var type = buffer_read(buffer, buffer_u8);
			var player_id = buffer_read(buffer, buffer_u8);
			change_items(global.board_items[item_id], type, player_id);
			break;
			
		case ClientTCP.ChangeSpace:
			var space = buffer_read(buffer, buffer_u8);
			change_space(space);
			break;
		#endregion
			
		#region Events
		case ClientTCP.BoardStart:
			global.game_id = buffer_read(buffer, buffer_string);
			global.seed_bag = buffer_read_array(buffer, buffer_u64);
			global.initial_rolls = buffer_read_array(buffer, buffer_u8);
			break;
		
		case ClientTCP.TurnStart:
			turn_start();
			break;
			
		case ClientTCP.TurnNext:
			turn_next();
			break;
			
		case ClientTCP.ChooseShine:
			var space_x = buffer_read(buffer, buffer_s16);
			var space_y = buffer_read(buffer, buffer_s16);
			place_shine(space_x, space_y);
			break;
			
		case ClientTCP.StartChanceTime:
			start_chance_time();
			break;
			
		case ClientTCP.RepositionChanceTime:
			with (objChanceTime) {
				reposition_chance_time();
			}
			break;
			
		case ClientTCP.EndChanceTime:
			with (objChanceTime) {
				rotate_turn = false;
				end_chance_time();
			}
			break;
			
		case ClientTCP.ChooseMinigame:
			choose_minigame();
			break;
			
		case ClientTCP.StartTheGuy:
			start_the_guy();
			break;
			
		case ClientTCP.ShowTheGuyOptions:
			with (objTheGuy) {
				show_the_guy_options();
			}
			break;
			
		case ClientTCP.EndTheGuy:
			with (objTheGuy) {
				rotate_turn = false;
				end_the_guy();
			}
			break;
			
		case ClientTCP.LastTurnsSayPlayerPlace:
			with (objLastTurns) {
				say_player_place();
			}
			break;
			
		case ClientTCP.LastTurnsHelpLastPlace:
			with (objLastTurns) {
				help_last_place();
			}
			break;
			
		case ClientTCP.LastTurnsEndLastTurns:
			with (objLastTurns) {
				end_last_turns();
			}
			break;
		#endregion
			
		#region Animations
		case ClientTCP.ItemApplied:
			var item_id = buffer_read(buffer, buffer_u8);
			item_applied(global.board_items[item_id]);
			break;
			
		case ClientTCP.ItemAnimation:
			var item_id = buffer_read(buffer, buffer_u8);
			var additional = buffer_read(buffer, buffer_s8);
			item_animation(item_id, additional);
			break;
			
		case ClientTCP.StartBlackholeSteal:
			with (objItemBlackholeAnimation) {
				start_blackhole_steal();
			}
			break;
			
		case ClientTCP.EndBlackholeSteal:
			with (objItemBlackholeAnimation) {
				steal_count = buffer_read(buffer, buffer_u8);
				end_blackhole_steal();
			}
			break;
		#endregion
			
		#region Minigames
		case ClientTCP.MinigameOverviewStart:
			var set = buffer_read(buffer, buffer_u8);
		
			with (objMinigameOverview) {
				start_minigame(set);
			}
			break;
			
		case ClientTCP.MinigameFinish:
			var player_id = buffer_read(buffer, buffer_u8);
			var timer = buffer_read(buffer, buffer_s32);
			var points = buffer_read(buffer, buffer_s32);
			var signal = buffer_read(buffer, buffer_bool);
			var info = global.minigame_info;
			var scoring = info.player_scores[player_id - 1];
			scoring.ready = true;
			scoring.timer = timer;
			scoring.points = points;
			
			if (info.is_finished || signal) {
				minigame_finish();
			}
			break;
			
		case ClientTCP.Minigame4vs_Lead_Input:
			with (objMinigameController) {
				var player_id = buffer_read(buffer, buffer_u8);
				var input_id = buffer_read(buffer, buffer_u8);
				
				array_push(network_inputs, {
					input_player_id: player_id,
					input_input_id: input_id
				});
				
				if (alarm[9] == -1) {
					alarm[9] = 1;
				}
			}
			break;
			
		case ClientTCP.Minigame4vs_Haunted_Boo:
			var player_id = buffer_read(buffer, buffer_u8);
			
			with (objMinigame4vs_Haunted_Boo) {
				if (!array_contains(player_targets, player_id)) {
					array_push(player_targets, player_id);
				}
			}
			break;
			
		case ClientTCP.Minigame4vs_Magic_Hold:
			var player_turn = buffer_read(buffer, buffer_u8);
			var order = buffer_read(buffer, buffer_s8);
			
			with (objMinigame4vs_Magic_Items) {
				if (self.order == order && self.player_turn == player_turn) {
					hold_item(false);
					break;
				}
			}
			break;
			
		case ClientTCP.Minigame4vs_Magic_Release:
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
			break;
			
		case ClientTCP.Minigame4vs_Mansion_Door:
			var row = buffer_read(buffer, buffer_u8);
			var col = buffer_read(buffer, buffer_u8);
			
			with (objMinigame4vs_Mansion_Door) {
				if (self.row == row && self.col == col) {
					open_door(false);
					break;
				}
			}
			break;
			
		case ClientTCP.Minigame4vs_Painting_Platform:
			var platform_x = buffer_read(buffer, buffer_s32);
			var platform_y = buffer_read(buffer, buffer_s32);
			var new_id = buffer_read(buffer, buffer_u8);
			
			with (objMinigame4vs_Painting_Platform) {
				if (x == platform_x && y == platform_y) {
					platform_paint(new_id, false);
					break;
				}
			}
			break;
			
		case ClientTCP.Minigame1vs3_Avoid_Block:
			var attack = buffer_read(buffer, buffer_u8);
			
			with (objMinigame1vs3_Avoid_Block) {
				if (image_index == attack) {
					activate(attack, true);
					break;
				}
			}
			break;
			
		case ClientTCP.Minigame1vs3_Conveyor_Switch:
			var image = buffer_read(buffer, buffer_u8);
			
			with (objMinigame1vs3_Conveyor_Switch) {
				if (image_index == image) {
					activate(image, true);
					break;
				}
			}
			break;
			
		case ClientTCP.Minigame1vs3_Showdown_Block:
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
			
			objMinigameController.alarm[4] = get_frames(1);
			break;
			
		case ClientTCP.Minigame1vs3_Coins_Coin:
			if (objMinigameController.info.is_finished) {
				return;
			}
			
			var player_id = buffer_read(buffer, buffer_u8);
			minigame4vs_points(player_id, 1);
			break;
			
		case ClientTCP.Minigame1vs3_Coins_HoldSpike:
			var spike_count = buffer_read(buffer, buffer_u32);
			
			with (objMinigame1vs3_Coins_Spike) {
				if (count == spike_count) {
					with (objPlayerBase) {
						if (x < 400) {
							other.follow = id;
						}
					}
		
					objMinigameController.alarm[5] = get_frames(0.25);
				}
			}
			break;
			
		case ClientTCP.Minigame1vs3_Coins_ThrowSpike:
			var spike_count = buffer_read(buffer, buffer_u32);
			var spike_x = buffer_read(buffer, buffer_s32);
			var spike_y = buffer_read(buffer, buffer_s32);
			var vspd = buffer_read(buffer, buffer_f16);
		
			with (objMinigame1vs3_Coins_Spike) {
				if (count == spike_count) {
					x = spike_x;
					y = spike_y;
					vspeed = vspd;
					throw_spike(false);
				}
			}	
			break;
			
		case ClientTCP.Minigame1vs3_Chase_Solo:
			var action = buffer_read(buffer, buffer_string);
			array_push(objMinigame1vs3_Chase_Controller.network_solo_actions, action);
			break;
			
		case ClientTCP.Minigame1vs3_Chase_Team:
			var action = buffer_read(buffer, buffer_string);
			array_push(objMinigame1vs3_Chase_Controller.network_team_actions, action);
			break;
			
		case ClientTCP.Minigame2vs2_Maze_Item:
			var player_id = buffer_read(buffer, buffer_u8);
			var item_x = buffer_read(buffer, buffer_s16);
			var item_y = buffer_read(buffer, buffer_s16);
			
			with (objMinigame2vs2_Maze_Item) {
				if (x == item_x && y == item_y) {
					collect_item(focus_player_by_id(player_id));
				}
			}
			break;
			
		case ClientTCP.Minigame2vs2_Fruits_Fruit:
			var player_id = buffer_read(buffer, buffer_u8);
			var points = buffer_read(buffer, buffer_s8);
			minigame4vs_points(player_id, points);
			break;
			
		case ClientTCP.Minigame2vs2_Buttons_Button:
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
			break;
			
		case ClientTCP.Minigame2vs2_Colorful_PatternMoveVertical:
			var pattern_x = buffer_read(buffer, buffer_u16);
			var index = buffer_read(buffer, buffer_u8);
			var v = buffer_read(buffer, buffer_s8);
			
			with (objMinigame2vs2_Colorful_Patterns) {
				if (x == pattern_x) {
					pattern_move_vertical(index, v, false);
					break;
				}
			}
			break;
			
		case ClientTCP.Minigame2vs2_Colorful_PatternMoveHorizontal:
			var pattern_x = buffer_read(buffer, buffer_u16);
			var index = buffer_read(buffer, buffer_u8);
			var h = buffer_read(buffer, buffer_s8);
			
			with (objMinigame2vs2_Colorful_Patterns) {
				if (x == pattern_x) {
					pattern_move_horizontal(index, h, false);
					break;
				}
			}
			break;
			
		case ClientTCP.Minigame2vs2_Colorful_PatternSelect:
			var pattern_x = buffer_read(buffer, buffer_u16);
			var index = buffer_read(buffer, buffer_u8);
			
			with (objMinigame2vs2_Colorful_Patterns) {
				if (x == pattern_x) {
					pattern_select(index, false);
					break;
				}
			}
			break;
		#endregion
		
		#region Results
		case ClientTCP.ResultsCoins:
			with (objResults) {
				results_coins();
			}
			break;
			
		case ClientTCP.ResultsBonus:
			var player_id = buffer_read(buffer, buffer_u8);
			var scores_ids = buffer_read_array(buffer, buffer_string);
			var scores_scores = buffer_read_array(buffer, buffer_s32);
			global.bonus_shines_ready[player_id - 1] = true;
			
			for (var i = 0; i < array_length(scores_ids); i++) {
				global.bonus_shines[$ scores_ids[i]].scores[player_id - 1] = scores_scores[i];
			}
		
			with (objResults) {
				results_bonus();
			}
			break;
			
		case ClientTCP.ResultsBonusShineGoUp:
			with (objResultsBonusShine) {
				go_up();
			}
			break;
			
		case ClientTCP.ResultsBonusShineNextBonus:
			with (objResultsBonusShine) {
				next_bonus();
			}
			break;
		
		case ClientTCP.ResultsWon:
			with (objResults) {
				results_won();
			}
			break;
			
		case ClientTCP.ResultsEnd:
			with (objResults) {
				results_end();
			}
			break;
			
		case ClientTCP.ResultsProceed:
			with (objResults) {
				results_proceed();
			}
			break;
		#endregion
	}
}

function network_read_client_udp(buffer, data_id) {
	switch (data_id) {
		#region Network
		case ClientUDP.Initialize:
			global.udp_ready = true;
			objNetworkClient.alarm[1] = 0;
			
			buffer_seek_begin();
			buffer_write_action(ClientTCP.LobbyList);
			network_send_tcp_packet();
			break;
		
		case ClientUDP.Heartbeat:
			if (IS_ONLINE) {
				objNetworkClient.alarm[0] = get_frames(9);
			}
			break;
			
		case ClientUDP.LobbyStart:
			music_fade();
			audio_play_sound(global.sound_cursor_big_select, 0, false);
			break;
		
		case ClientUDP.PlayerData:
			player_read_data(buffer);
			break;
			
		case ClientUDP.PlayerShoot:
			var player_id = buffer_read(buffer, buffer_u8);
			var xx = buffer_read(buffer, buffer_s16);
			var yy = buffer_read(buffer, buffer_s16);
			var hspd = buffer_read(buffer, buffer_s8);
			var b = instance_create_layer(xx, yy, "Actors", objBullet);
			b.network_id = player_id;
			b.hspeed = hspd;
			break;
		#endregion
			
		#region Interfaces
		case ClientUDP.MapLook:
			var look_x = buffer_read(buffer, buffer_f32);
			var look_y = buffer_read(buffer, buffer_f32);
			
			with (objMapLook) {
				self.look_x = look_x;
				self.look_y = look_y;
			}
			break;
		
		case ClientUDP.ChangeChoiceSelected:
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
			break;
			
		case ClientUDP.ChangeDialogueAnswer:
			if (instance_exists(objDialogue)) {
				var answer_index = buffer_read(buffer, buffer_u8);
				objDialogue.answer_index = answer_index;
				audio_play_sound(global.sound_cursor_select, 0, false);
			}
			break;
			
		case ClientUDP.ChangeShopSelected:
			if (instance_exists(objShop)) {
				objShop.option_selected = buffer_read(buffer, buffer_u8);
				audio_play_sound(global.sound_cursor_select, 0, false);
			}
			break;
			
		case ClientUDP.ChangeBlackholeSelected:
			if (instance_exists(objBlackhole)) {
				objBlackhole.option_selected = buffer_read(buffer, buffer_u8);
				audio_play_sound(global.sound_cursor_select, 0, false);
			}
			break;
		#endregion
			
		#region Events
		case ClientUDP.CrushTheGuy:
			objTheGuy.alarm[5] = 1;
			break;
			
		case ClientUDP.NoNoTheGuy:
			with (objTheGuyHead) {
				snd = audio_play_sound(sndTheGuyNoNo, 0, false);
				image_speed = 1;
			}
		
			objTheGuyEye.image_speed = 1;
			break;
		#endregion
		
		#region Minigames
		case ClientUDP.Minigame2vs2_Squares_Halfs:
			var player_id = buffer_read(buffer, buffer_u8);
			var angle = buffer_read(buffer, buffer_u16);
			
			with (objMinigame2vs2_Squares_Halfs) {
				if (!done && network_id == player_id) {
					image_angle = angle;
					break;
				}
			}
			break;
		#endregion
	}
}