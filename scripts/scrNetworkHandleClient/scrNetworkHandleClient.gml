enum ClientTCP {
	ReceiveID,
	PlayerConnect,
	PlayerDisconnect,
	PlayerMove,
	StartTurn,
	ChangeChoiceSelected,
	NextTurn,
	ShowDice,
	RollDice,
	HideDice,
	LessRoll,
	ShowChest,
	OpenChest,
	ChooseShine,
	ChangeShines,
	ChangeCoins,
	ChangeItems,
	ChangeSpace,
	SkipDialogueText,
	ChangeDialogueText,
	ChangeDialogueAnswer,
	EndDialogue,
	ShowShop,
	ChangeShopSelected,
	EndShop,
	ShowBlackhole,
	ChangeBlackholeSelected,
	EndBlackhole,
	ShowMultipleChoices,
	ChangeMultipleChoiceSelected,
	EndMultipleChoices,
	ItemApplied,
	ItemAnimation,
	StartBlackholeSteal,
	EndBlackholeSteal
}

enum ClientUDP {
	Heartbeat,
	PlayerMove,
	LessRoll,
	SendSound
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
		case ClientTCP.ReceiveID:
			global.player_id = buffer_read(buffer, buffer_u8);
			global.skin_current = global.player_id - 1;
			
			for (var i = 0; i < global.player_max; i++) {
				if (global.player_client_list[i] == null) {
					player_join(i + 1);
				}
			}
			
			array_insert(global.all_ai_actions, global.player_id - 1, null);
			objPlayerBase.network_id = global.player_id;
			break;
			
		case ClientTCP.PlayerConnect:
			var player_id = buffer_read(buffer, buffer_u8);
			player_join(player_id);
			break;
				
		case ClientTCP.PlayerDisconnect:
			var player_id = buffer_read(buffer, buffer_u8);
			player_leave(player_id);
			break;
			
		case ClientTCP.PlayerMove:
			player_read_data(buffer);
			break;
			
		case ClientTCP.StartTurn:
			turn_start();
			break;
			
		case ClientTCP.ChangeChoiceSelected:
			objTurnChoices.option_selected = buffer_read(buffer, buffer_u8);
			audio_play_sound(global.sound_cursor_move, 0, false);
			break;
			
		case ClientTCP.NextTurn:
			turn_next();
			break;
			
		case ClientTCP.ShowDice:
			var player_id = buffer_read(buffer, buffer_u8);
			var seed = buffer_read(buffer, buffer_u16);
			random_set_seed(seed);
			show_dice(player_id);
			break;
			
		case ClientTCP.RollDice:
			objDice.roll = buffer_read(buffer, buffer_u8);
			roll_dice();
			break;
			
		case ClientTCP.HideDice:
			hide_dice();
			break;
			
		case ClientTCP.LessRoll:
			global.dice_roll--;
			break;
			
		case ClientTCP.ShowChest:
			show_chest();
			break;
			
		case ClientTCP.OpenChest:
			objHiddenChest.image_speed = 1;
			break;
			
		case ClientTCP.ChooseShine:
			var space_x = buffer_read(buffer, buffer_s16);
			var space_y = buffer_read(buffer, buffer_s16);
			place_shine(space_x, space_y);
			break;
			
		case ClientTCP.ChangeShines:
			var amount = buffer_read(buffer, buffer_s16);
			var type = buffer_read(buffer, buffer_u8);
			change_shines(amount, type);
			break;
			
		case ClientTCP.ChangeCoins:
			var amount = buffer_read(buffer, buffer_s16);
			var type = buffer_read(buffer, buffer_u8);
			change_coins(amount, type);
			break;
			
		case ClientTCP.ChangeItems:
			var item_id = buffer_read(buffer, buffer_u8);
			var type = buffer_read(buffer, buffer_u8);
			change_items(global.board_items[item_id], type);
			break;
			
		case ClientTCP.ChangeSpace:
			var space = buffer_read(buffer, buffer_u8);
			change_space(space);
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
			
		case ClientTCP.ChangeDialogueAnswer:
			if (instance_exists(objDialogue)) {
				var answer_index = buffer_read(buffer, buffer_u8);
				objDialogue.answer_index = answer_index;
				audio_play_sound(global.sound_cursor_select, 0, false);
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
			
		case ClientTCP.ChangeShopSelected:
			if (instance_exists(objShop)) {
				objShop.option_selected = buffer_read(buffer, buffer_u8);
				audio_play_sound(global.sound_cursor_select, 0, false);
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
			
		case ClientTCP.ChangeBlackholeSelected:
			if (instance_exists(objBlackhole)) {
				objBlackhole.option_selected = buffer_read(buffer, buffer_u8);
				audio_play_sound(global.sound_cursor_select, 0, false);
			}
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
	}
}

function network_read_client_udp(buffer, data_id) {
	switch (data_id) {
		case ClientUDP.Heartbeat:
			if (instance_exists(objNetworkClient)) {
				objNetworkClient.alarm[0] = get_frames(2);
			}
			break;
		
		case ClientUDP.PlayerMove:
			player_read_data(buffer);
			break;
			
		case ClientUDP.LessRoll:
			global.dice_roll--;
			break;
			
		case ClientUDP.SendSound:
			audio_play_sound(sndTest, 0, false);
			break;
	}
}