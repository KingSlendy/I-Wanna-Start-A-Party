image_alpha = lerp(image_alpha, alpha_target, 0.4);

if (alpha_target == 0 && point_distance(image_alpha, 0, alpha_target, 0) < 0.001) {
	instance_destroy();
	exit;
}

if (!is_local_turn() || alpha_target == 0) {
	exit;
}

var scroll = (global.actions.right.pressed(network_id) - global.actions.left.pressed(network_id));
var prev_choice = global.choice_selected;

if (global.choice_selected == -1) {
	global.choice_selected = 0;
	skip_empty_choice(1);
}

if (scroll != 0) {
	skip_empty_choice(scroll);
}

if (global.choice_selected != prev_choice) {
	audio_play_sound(global.sound_cursor_move, 0, false);
	
	buffer_seek_begin();
	buffer_write_action(ClientTCP.ChangeMultipleChoiceSelected);
	buffer_write_data(buffer_u8, global.choice_selected);
	network_send_tcp_packet();
}

if (global.actions.jump.pressed(network_id)) {
	if (availables[global.choice_selected]) {
		alpha_target = 0;
		audio_play_sound(global.sound_cursor_select, 0, false);
	} else {
		//audio_play_sound(global.sound_cursor_select, 0, false);
	}
}

if (!player_info_by_turn().item_used && global.actions.shoot.pressed()) {
	final_action = null;
	alpha_target = 0;
	audio_play_sound(global.sound_cursor_back, 0, false);
}

if (alpha_target == 0) {
	buffer_seek_begin();
	buffer_write_action(ClientTCP.EndMultipleChoices);
	network_send_tcp_packet();
}