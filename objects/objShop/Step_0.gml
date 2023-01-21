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

	if (global.actions.jump.pressed(network_id)) {
		io_clear();
		
		if (player_info.coins >= item_selected.price) {
			change_dialogue([
				new Message("Are you sure you wanna buy {COLOR,0000FF}" + item_selected.name + "{COLOR,FFFFFF}?", [
					["Buy " + draw_coins_price(item_selected.price), [
						new Message("Thank you for buying!",, function() {
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
									} until (room != rBoardNsanity || item.id != ItemType.Reverse);
									
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
						
							change_coins(-item_selected.price, CoinChangeType.Spend).final_action = action;
							bonus_shine_by_id(BonusShines.MostPurchases).increase_score(global.player_turn, item_selected.price);
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
	
	if (!focus_player_by_id().ai && global.actions.shoot.pressed(network_id)) {
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