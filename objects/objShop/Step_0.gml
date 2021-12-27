offset_pos = lerp(offset_pos, offset_target, 0.2);

if (point_distance(offset_pos, 0, offset_target, 0) < 0.001) {
	offset_pos = offset_target;
	
	if (offset_pos == 0) {
		instance_destroy();
		exit;
	}
}

offset_y = -454 * (1 - offset_pos);

if (offset_pos != offset_target) {
	exit;
}

if (shopping && is_player_turn()) {
	var scroll = (global.down_action.pressed() - global.up_action.pressed());
	var prev_selected = option_selected;

	if (option_selected == -1) {
		option_selected = option_previous;
	}

	option_selected = (option_selected + 5 + scroll) % 5;
	item_selected = stock[option_selected];

	if (prev_selected != option_selected) {
		change_dialogue([
			"{COLOR,0000FF}" + item_selected.name + "{COLOR,FFFFFF}\n" + item_selected.desc
		], 0);
		
		audio_play_sound(global.sound_cursor_move, 0, false);
		
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ChangeShopSelected);
		buffer_write_data(buffer_u8, option_selected);
		network_send_tcp_packet();
	}

	if (global.jump_action.pressed()) {
		io_clear();
		
		if (player_turn_info.coins >= item_selected.price) {
			change_dialogue([
				new Message("Are you sure you wanna buy {COLOR,0000FF}" + item_selected.name + "{COLOR,FFFFFF}?", [
					["Buy (" + draw_coins_price(item_selected.price) + ")", [
						new Message("Thank you for buying!",, function() {
							with (objShop) {
								shop_end();
							}
							
							with (objDialogue) {
								text_end();
							}
						
							change_coins(-item_selected.price, CoinChangeType.Spend).final_action = function() {
								change_items(item_selected, ItemChangeType.Gain).final_action = board_advance;
							}
						})
					]],
				
					["No", [
						new Message("",, function() {
							objDialogue.active = false;
							objDialogue.endable = false;
							objShop.shopping = true;
							option_previous = option_selected;
							option_selected = -1;
						})
					]]
				])
			]);
			
			shopping = false;
		} else {
			change_dialogue([
				"You don't have enough coins to buy that item!"
			]);
			
			objDialogue.active = false;
			objDialogue.endable = false;
		}
	}
	
	if (global.shoot_action.pressed()) {
		change_dialogue([
			new Message("Hope to see you again soon!",, function() {
				with (objShop) {
					shop_end();
				}
				
				board_advance();
			})
		]);
		
		shopping = false;
	}
}