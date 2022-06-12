image_alpha = lerp(image_alpha, alpha_target, 0.4);

if (!is_local_turn() || !can_choose() || image_alpha < 0.5) {
	exit;
}

var scroll = (global.actions.down.pressed(network_id) - global.actions.up.pressed(network_id));
var prev_choice = option_selected;

if (option_selected == -1) {
	option_selected = 0;
}

option_selected = (option_selected + 3 + scroll) % 3;

if (option_selected != prev_choice) {
	audio_play_sound(global.sound_cursor_move, 0, false);
	
	buffer_seek_begin();
	buffer_write_action(ClientUDP.ChangeChoiceSelected);
	buffer_write_data(buffer_u8, option_selected);
	network_send_udp_packet();
}

if (global.actions.jump.pressed(network_id)) {
	audio_play_sound(global.sound_cursor_select, 0, false);
	
	switch (option_selected) {
		case 0:
			show_dice(network_id);
			break;
			
		case 1:
			if (available_item) {
				var items = all_item_stats(player_info);
				
				show_multiple_choices(items.names, items.sprites, items.descs, items.availables).final_action = function() {
					var item = player_info_by_turn().items[global.choice_selected];
					change_items(item, ItemChangeType.Use);
				}
			}
			break;
		
		case 2:
			if (!focus_player.ai) {
				show_map();
			}
			break;
	}
}