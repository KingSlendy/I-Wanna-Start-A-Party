image_alpha = lerp(image_alpha, alpha_target, 0.4);

if (!can_choose() || !is_player_turn() || image_alpha < 0.5) {
	exit;
}

var scroll = (global.down_action.pressed() - global.up_action.pressed());
var prev_choice = option_selected;

if (option_selected == -1) {
	option_selected = 0;
}

option_selected = (option_selected + 3 + scroll) % 3;

if (option_selected != prev_choice) {
	audio_play_sound(global.sound_cursor_move, 0, false);
	
	buffer_seek_begin();
	buffer_write_from_host(false);
	buffer_write_action(Client_TCP.ChangeChoiceSelected);
	buffer_write_data(buffer_u8, option_selected);
	network_send_tcp_packet();
}

if (global.jump_action.pressed()) {
	audio_play_sound(global.sound_cursor_select, 0, false);
	
	switch (option_selected) {
		case 0:
			show_dice();
			break;
			
		case 1:
			if (available_item) {
				var items = [];
				
				for (var i = 0; i < 3; i++) {
					if (player_turn_info.items[i] == null) {
						array_push(items, "");
					} else {
						array_push(items, "{SPRITE," + sprite_get_name(player_turn_info.items[i].sprite) + ",0,-32,-32,1,1}");
					}
				}
				
				show_multiple_choices(items).final_action = function() {
					var item = get_player_turn_info().items[global.choice_selected];
					change_items(item, ItemChangeType.Use);
				}
			}
			break;
		
		case 2:
			instance_create_layer(0, 0, "Managers", objMapLook);
			break;
	}
}