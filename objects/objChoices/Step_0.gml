image_alpha = lerp(image_alpha, alpha_target, 0.4);

if (!can_choose() || !is_player_turn()) {
	exit;
}

var scroll = (global.down_action.pressed() - global.up_action.pressed());
var prev_choice = choice_selected;

if (choice_selected == -1) {
	choice_selected = 0;
}

choice_selected = (choice_selected + 3 + scroll) % 3;

if (choice_selected != prev_choice) {
	buffer_seek_begin();
	buffer_write_from_host(false);
	buffer_write_action(Client_TCP.ChangeChoiceSelected);
	buffer_write_data(buffer_u8, choice_selected);
	network_send_tcp_packet();
}

if (global.jump_action.pressed()) {
	switch (choice_selected) {
		case 0:
			show_dice();
			break;
			
		case 1:
			break;
		
		case 2:
			instance_create_layer(0, 0, "Managers", objMapLook);
			break;
	}
}