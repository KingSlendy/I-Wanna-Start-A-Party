timer++;
timer %= 1000;
offset_pos = lerp(offset_pos, offset_target, 0.2);

if (point_distance(offset_pos, 0, offset_target, 0) < 0.001) {
	offset_pos = offset_target;
	
	if (offset_pos == 0) {
		instance_destroy();
		exit;
	}
}

offset_y = -(height / 2 + display_get_gui_height() / 2) * (1 - offset_pos);

if (offset_pos != offset_target) {
	exit;
}

if (shopping && is_local_turn()) {
	var scroll = (global.actions.down.pressed(network_id) - global.actions.up.pressed(network_id));
	var prev_selected = option_selected;

	if (option_selected == -1) {
		option_selected = option_previous;
	}

	option_selected = (option_selected + array_length(stock) + scroll) % array_length(stock);
	item_selected = stock[option_selected];

	if (prev_selected != option_selected) {
		change_dialogue([
			item_selected.desc
		], 0);
		
		audio_play_sound(global.sound_cursor_move, 0, false);
		
		buffer_seek_begin();
		buffer_write_action(ClientUDP.ChangeShopSelected);
		buffer_write_data(buffer_u8, option_selected);
		network_send_udp_packet();
	}
	
	objDialogue.endable = false;

	if (global.actions.jump.pressed(network_id)) {
		global.actions.jump.consume();
		price = item_selected.price;
		
		if (room == rBoardBaba && global.baba_toggled[2]) {
			switch (global.baba_blocks[2]) {
				case 0: price *= 2; break;
				case 1: price /= 2; break;
				case 2: price = 0; break;
			}
			
			price = floor(price);
		}
		
		if (player_info.coins >= price) {
			change_dialogue([
				new Message(language_get_text("PARTY_BOARD_SHOP_WANNA_BUY", ["{Color}", "{COLOR,0000FF}"], ["{Item}", item_selected.name], ["{Color}", "{COLOR,FFFFFF}"]), [
					[language_get_text("WORD_GENERIC_BUY_COINS", ["{X coins}", draw_coins_price(price)]), [
						new Message(language_get_text("PARTY_BOARD_SHOP_ITEM_THANK"),, function() {
							with (objShop) {
								shop_end();
							}
							
							with (objDialogue) {
								text_end();
							}
						
							if (item_selected.id != ItemType.ItemBag) {
								var action = function() {
									change_items(item_selected, ItemChangeType.Gain).final_action = board_advance;
								}
							} else {
								global.bag_items = [];
								
								repeat (3) {
									var item = null;
									
									do {
										item = global.board_items[irandom(ItemType.Length - 2)];
									} until (!array_contains(item.ignore_in, room));
									
									array_push(global.bag_items, item);
								}
								
								var action = function() {
									change_items(global.bag_items[0], ItemChangeType.Gain).final_action = function() {
										change_items(global.bag_items[1], ItemChangeType.Gain).final_action = function() {
											change_items(global.bag_items[2], ItemChangeType.Gain).final_action = board_advance;
										}
									}
								}
							}
						
							change_coins(-price, CoinChangeType.Spend).final_action = action;
							bonus_shine_by_id(BonusShines.MostPurchases).increase_score(global.player_turn, item_selected.price);
						})
					]],
				
					[language_get_text("WORD_GENERIC_NO"), [
						new Message("",, function() {
							objDialogue.active = false;
							objShop.shopping = true;
							option_previous = option_selected;
							option_selected = -1;
							global.actions.jump.consume();
						})
					]]
				])
			]);
			
			shopping = false;
		} else {
			change_dialogue([
				language_get_text("PARTY_BOARD_SHOP_ITEM_NOT_ENOUGH")
			]);
			
			objDialogue.active = false;
		}
	}
	
	if (!focus_player_by_id().ai && global.actions.shoot.pressed(network_id)) {
		change_dialogue([
			new Message(language_get_text("PARTY_BOARD_SHOP_SEE_YOU"),, function() {
				with (objShop) {
					shop_end();
				}
				
				board_advance();
			})
		]);
		
		shopping = false;
	}
}