enum ClientTCP {
	//Network
	ReceiveMasterID,
	ReceiveID,
	ResendID,
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
	PlayerMove,
	PlayerShoot,
	PlayerKill,
	
	//Interactables
	ShowDice,
	RollDice,
	HideDice,
	ShowChest,
	OpenChest,
	SpawnChanceTimeBox,
	
	//Interfaces
	SpawnPlayerInfo,
	ChangeChoiceAlpha,
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
	CrushTheGuy,
	EndTheGuy,
	
	//Animations
	ItemApplied,
	ItemAnimation,
	StartBlackholeSteal,
	EndBlackholeSteal,
	
	//Minigames
	MinigameOverviewStart,
	MinigameFinish,
	Minigame4vs_Lead_Input,
	Minigame2vs2_Buttons_Button,
	Minigame1vs3_Avoid_Block,
	Minigame1vs3_Conveyor_Switch,
	Minigame2vs2_Maze_Item,
	Minigame2vs2_Fruits_Fruit,
	
	//Results
	ResultsCoins,
	ResultsBonus,
	ResultsBonusShineGoUp,
	ResultsBonusShineNextBonus,
	ResultsWon,
	ResultsEnd
}

enum ClientUDP {
	//Networking
	Heartbeat,
	PlayerMove,
	
	//Interfaces
	ChangeChoiceSelected,
	ChangeDialogueAnswer,
	ChangeShopSelected,
	ChangeBlackholeSelected
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
			
		case ClientTCP.ResendID:
			player_leave_all();
			global.player_id = buffer_read(buffer, buffer_u8);
			player_join_all();
			break;
			
		case ClientTCP.PlayerConnect:
			var player_id = buffer_read(buffer, buffer_u8);
			player_join(player_id);
			break;
				
		case ClientTCP.PlayerDisconnect:
			var player_id = buffer_read(buffer, buffer_u8);
		
			if (!global.lobby_started) {
				player_leave(player_id);
			} else {
				popup(focus_player_by_id(player_id).network_name + " disconnected.\nExiting lobby.");
				network_disable();
			}
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
		
			with (objParty) {
				array_push(network_actions, [action, player_id]);
				//print(network_actions);
			}
			break;
			
		case ClientTCP.PlayerMove:
			player_read_data(buffer);
			break;
			
		case ClientTCP.PlayerShoot:
			var player_id = buffer_read(buffer, buffer_u8);
			var xx = buffer_read(buffer, buffer_s16);
			var yy = buffer_read(buffer, buffer_s16);
			var hspd = buffer_read(buffer, buffer_s8);
			var b = instance_create_layer(xx, yy, "Actors", objBullet);
			b.network_id = player_id;
			b.hspeed = hspd;
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
		
		case ClientTCP.LessRoll:
			global.dice_roll--;
			break;
			
		case ClientTCP.SkipDialogueText:
			with (objDialogue) {
				text_display.text.skip();
			}
			
			audio_play_sound(global.sound_cursor_select, 0, false);
			break;
			
		case ClientTCP.ChangeDialogueText:
			var d = objDialogue;
		
			if (!instance_exists(objDialogue)) {
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
			
		case ClientTCP.CrushTheGuy:
			objTheGuy.alarm[5] = 1;
			break;
			
		case ClientTCP.EndTheGuy:
			with (objTheGuy) {
				rotate_turn = false;
				end_the_guy();
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
			minigame_4vs_points(objMinigameController.info, player_id, points);
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
		#endregion
	}
}

function network_read_client_udp(buffer, data_id) {
	switch (data_id) {
		//Network
		case ClientUDP.Heartbeat:
			if (instance_exists(objNetworkClient)) {
				objNetworkClient.alarm[0] = get_frames(9);
			}
			break;
		
		case ClientUDP.PlayerMove:
			player_read_data(buffer);
			break;
			
		//Interfaces
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
	}
}