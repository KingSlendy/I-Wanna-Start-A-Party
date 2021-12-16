enum Client_TCP {
	ReceiveID,
	PlayerConnect,
	PlayerDisconnect,
	PlayerMove,
	NextTurn,
	ShowDice,
	RollDice,
	LessRoll,
	ChooseShine,
	ChangeShines,
	ChangeCoins
}

enum Client_UDP {
	Heartbeat,
	PlayerMove,
	Test
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
	
		if (buffer_get_size(buffer) + 5 != match_size) {
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
			
		case Client_TCP.NextTurn:
			global.player_turn = buffer_read(buffer, buffer_u8);
			board_start();
			break;
			
		case Client_TCP.ShowDice:
			var dice_x = buffer_read(buffer, buffer_s16);
			var dice_y = buffer_read(buffer, buffer_s16);
			instance_create_layer(dice_x, dice_y, "Actors", objDice);
			break;
			
		case Client_TCP.RollDice:
			global.dice_roll = buffer_read(buffer, buffer_u8);
			instance_destroy(objDice);
			break;
			
		case Client_TCP.LessRoll:
			global.dice_roll--;
			break;
			
		case Client_TCP.ChooseShine:
			var space_x = buffer_read(buffer, buffer_s16);
			var space_y = buffer_read(buffer, buffer_s16);
			
			with (objSpaces) {
				if (space_shine) {
					image_index = SpaceType.Blue;
				}
			}
			
			with (objSpaces) {
				if (x == space_x && y == space_y) {
					image_index = SpaceType.Shine;
					break;
				}
			}
			
			global.shine_spotted = true;
			break;
			
		case Client_TCP.ChangeShines:
			var player_id = buffer_read(buffer, buffer_u8);
			var amount = buffer_read(buffer, buffer_u8);
			get_player_info(player_id).shines = amount;
			break;
			
		case Client_TCP.ChangeCoins:
			var player_id = buffer_read(buffer, buffer_u8);
			var amount = buffer_read(buffer, buffer_s16);
			change_coins(amount, player_id);
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
			
		case Client_UDP.Test:
			show_message(global.player_id);
			break;
	}
}