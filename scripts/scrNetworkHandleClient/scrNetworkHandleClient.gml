enum Client_TCP {
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
	ShowMultipleChoices,
	ChangeMultipleChoiceSelected,
	EndMultipleChoices,
	ItemApplied,
	ItemAnimation
}

enum Client_UDP {
	Heartbeat,
	PlayerMove,
	LessRoll,
	SendSound
}

function network_read_client(ip, port, buffer) {
	if (buffer_get_size(buffer) == 0) {
		return;
	}
	
	buffer_seek_begin(buffer);
	
	try {
		var match_id = buffer_read(buffer, buffer_u8);
	
		if (match_id != FAILCHECK_ID) {
			return;
		}
		
		var match_size = buffer_read(buffer, buffer_u16);
	
		if (buffer_get_size(buffer) != match_size) {
			return;
		}
		
		var is_tcp = buffer_read(buffer, buffer_bool);
		var from_host = buffer_read(buffer, buffer_bool);
		var data_id = buffer_read(buffer, buffer_u16);
	} catch (_) {
		return;
	}
	
	if (from_host) {
		if (is_tcp) {
			network_read_client_tcp(ip, port, buffer, data_id);
		} else {
			network_read_client_udp(buffer, data_id);
		}
	}
}

function network_read_client_tcp(ip, port, buffer, data_id) {
	switch (data_id) {
		case Client_TCP.ReceiveID:
			global.player_id = buffer_read(buffer, buffer_u8);
			global.skin_current = global.player_id - 1;
			
			for (var i = 0; i < global.player_id; i++) {
				if (global.player_list_client[i] == null) {
					player_join(i + 1, ip, port);
				}
			}
			break;
			
		case Client_TCP.PlayerConnect:
			var player_id = buffer_read(buffer, buffer_u8);
			player_join(player_id, ip, port);
			break;
				
		case Client_TCP.PlayerDisconnect:
			var player_id = buffer_read(buffer, buffer_u8);
			player_leave(player_id);
			break;
			
		case Client_TCP.PlayerMove:
			player_read_data(buffer);
			break;
			
		case Client_TCP.StartTurn:
			turn_start();
			break;
			
		case Client_TCP.ChangeChoiceSelected:
			objTurnChoices.option_selected = buffer_read(buffer, buffer_u8);
			audio_play_sound(global.sound_cursor_move, 0, false);
			break;
			
		case Client_TCP.NextTurn:
			next_turn();
			break;
			
		case Client_TCP.ShowDice:
			var player_id = buffer_read(buffer, buffer_u8);
			var seed = buffer_read(buffer, buffer_u16);
			random_set_seed(seed);
			show_dice(player_id);
			break;
			
		case Client_TCP.RollDice:
			objDice.roll = buffer_read(buffer, buffer_u8);
			roll_dice();
			break;
			
		case Client_TCP.HideDice:
			instance_destroy(objDice);
			break;
			
		case Client_TCP.LessRoll:
			global.dice_roll--;
			break;
			
		case Client_TCP.ShowChest:
			show_chest();
			break;
			
		case Client_TCP.OpenChest:
			objHiddenChest.image_speed = 1;
			break;
			
		case Client_TCP.ChooseShine:
			var space_x = buffer_read(buffer, buffer_s16);
			var space_y = buffer_read(buffer, buffer_s16);
			place_shine(space_x, space_y);
			break;
			
		case Client_TCP.ChangeShines:
			var amount = buffer_read(buffer, buffer_u8);
			var type = buffer_read(buffer, buffer_u8);
			change_shines(amount, type);
			break;
			
		case Client_TCP.ChangeCoins:
			var amount = buffer_read(buffer, buffer_s16);
			var type = buffer_read(buffer, buffer_u8);
			change_coins(amount, type);
			break;
			
		case Client_TCP.ChangeItems:
			var item_id = buffer_read(buffer, buffer_u8);
			var type = buffer_read(buffer, buffer_u8);
			change_items(global.board_items[item_id], type);
			break;
			
		case Client_TCP.ChangeSpace:
			var space = buffer_read(buffer, buffer_u8);
			change_space(space);
			break;
			
		case Client_TCP.SkipDialogueText:
			with (objDialogue) {
				text_display.text.skip();
			}
			
			audio_play_sound(global.sound_cursor_select, 0, false);
			break;
			
		case Client_TCP.ChangeDialogueText:
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
				
					if (data == "EOF") {
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
			
		case Client_TCP.ChangeDialogueAnswer:
			var answer_index = buffer_read(buffer, buffer_u8);
			objDialogue.answer_index = answer_index;
			audio_play_sound(global.sound_cursor_select, 0, false);
			break;
			
		case Client_TCP.EndDialogue:
			with (objDialogue) {
				endable = true;
				text_end();
			}
			break;
			
		case Client_TCP.ShowShop:
			var s = instance_create_layer(0, 0, "Managers", objShop);
			
			while (true) {
				try {
					array_push(s.stock, global.board_items[buffer_read(buffer, buffer_u8)]);;
				} catch (_) {
					return;
				}
			}
			break;
			
		case Client_TCP.ChangeShopSelected:
			objShop.option_selected = buffer_read(buffer, buffer_u8);
			audio_play_sound(global.sound_cursor_select, 0, false);
			break;
			
		case Client_TCP.EndShop:
			with (objShop) {
				shop_end();
			}
			break;
			
		case Client_TCP.ShowMultipleChoices:
			var choices = [];
			
			while (true) {
				var data = buffer_read(buffer, buffer_string);
				
				if (data == "EOF") {
					break;
				}
				
				array_push(choices, data);
			}
			
			show_multiple_choices(choices);
			break;
			
		case Client_TCP.ChangeMultipleChoiceSelected:
			global.choice_selected = buffer_read(buffer, buffer_u8);
			audio_play_sound(global.sound_cursor_move, 0, false);
			break;
			
		case Client_TCP.EndMultipleChoices:
			objMultipleChoices.alpha_target = 0;
			break;
			
		case Client_TCP.ItemApplied:
			var item_id = buffer_read(buffer, buffer_u8);
			item_applied(global.board_items[item_id]);
			break;
			
		case Client_TCP.ItemAnimation:
			var item_id = buffer_read(buffer, buffer_u8);
			item_animation(item_id);
			break;
	}
}

function network_read_client_udp(buffer, data_id) {
	switch (data_id) {
		case Client_UDP.Heartbeat:
			objNetworkClient.alarm[0] = game_get_speed(gamespeed_fps) * 3;
			break;
		
		case Client_UDP.PlayerMove:
			player_read_data(buffer);
			break;
			
		case Client_UDP.LessRoll:
			global.dice_roll--;
			break;
			
		case Client_UDP.SendSound:
			audio_play_sound(sndTest, 0, false);
			break;
	}
}