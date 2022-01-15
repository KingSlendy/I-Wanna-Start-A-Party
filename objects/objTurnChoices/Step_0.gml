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
	buffer_write_action(ClientTCP.ChangeChoiceSelected);
	buffer_write_data(buffer_u8, option_selected);
	network_send_tcp_packet();
}

if (global.actions.jump.pressed(network_id)) {
	audio_play_sound(global.sound_cursor_select, 0, false);
	
	switch (option_selected) {
		case 0:
			show_dice();
			break;
			
		case 1:
			if (available_item) {
				var item_names = [];
				var items = [];
				var item_descs = [];
				var item_availables = [];
				
				for (var i = 0; i < 3; i++) {
					var item = player_turn_info.items[i];
					
					if (item == null) {
						array_push(item_names, "");
						array_push(items, "");
						array_push(item_descs, "");
						array_push(item_availables, false);
					} else {
						array_push(item_names, item.name);
						array_push(items, "{SPRITE," + sprite_get_name(item.sprite) + ",0,-32,-32,1,1}");
						array_push(item_descs, item.desc);
						array_push(item_availables, item.use_criteria());
					}
				}
				
				show_multiple_choices(item_names, items, item_descs, item_availables).final_action = function() {
					var item = player_info_by_turn().items[global.choice_selected];
					change_items(item, ItemChangeType.Use);
				}
			}
			break;
		
		case 2:
			if (!focus_player.ai) {
				instance_create_layer(0, 0, "Managers", objMapLook);
			}
			break;
	}
}