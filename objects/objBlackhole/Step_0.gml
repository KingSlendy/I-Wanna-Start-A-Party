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

if (selecting && is_local_turn()) {
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
		buffer_write_action(ClientUDP.ChangeBlackholeSelected);
		buffer_write_data(buffer_u8, option_selected);
		network_send_udp_packet();
	}

	if (global.actions.jump.pressed(network_id)) {
		io_clear();
		
		if (player_info.coins >= item_selected.price && item_selected.can_select) {
			change_dialogue([
				new Message(language_get_text("PARTY_BOARD_BLACKHOLE_WANNA_STEAL", "{COLOR,0000FF}", item_selected.name, "{COLOR,FFFFFF}"), [
					["Yes " + draw_coins_price(item_selected.price), [
						new Message(language_get_text("PARTY_BOARD_BLACKHOLE_GOOD_CHOICE"),, function() {
							with (objBlackhole) {
								blackhole_end();
							}
							
							with (objDialogue) {
								text_end();
							}
						
							change_coins(-item_selected.price, CoinChangeType.Spend).final_action = function() {
								show_multiple_player_choices(language_get_text("PARTY_BOARD_BLACKHOLE_WHICH_PLAYER_STEAL"), function(turn) {
									var player_info = player_info_by_turn(turn);
									
									switch (option_selected) {
										case 0: return (player_info.coins > 0);
										case 1: return (player_info.shines > 0);
									}
								}, true).final_action = function() {
									item_animation(ItemType.Blackhole, option_selected).final_action = board_advance;
								}
							}
						})
					]],
				
					["No", [
						new Message("",, function() {
							objDialogue.active = false;
							objDialogue.endable = false;
							objBlackhole.selecting = true;
							option_previous = option_selected;
							option_selected = -1;
						})
					]]
				])
			]);
			
			selecting = false;
		} else {
			change_dialogue([
				language_get_text("PARTY_BOARD_BLACKHOLE_CANT")
			]);
			
			objDialogue.active = false;
			objDialogue.endable = false;
		}
	}
	
	if (!focus_player_by_id().ai && global.actions.shoot.pressed(network_id)) {
		change_dialogue([
			new Message(language_get_text("PARTY_BOARD_BLACKHOLE_SHAME"),, function() {
				with (objBlackhole) {
					blackhole_end();
				}
				
				board_advance();
			})
		]);
		
		selecting = false;
	}
}