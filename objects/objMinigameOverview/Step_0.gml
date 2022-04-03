switch (state) {
	case 0:
		alpha -= 0.03;
		
		if (alpha <= 0) {
			alpha = 0;
			state = -1;
		}
		break;
		
	case 1:
		alpha += 0.02;
		
		if (alpha >= 1) {
			info.is_practice = false;
			room_goto(info.reference.scene);
		}
		break;
		
	case 2:
		alpha += 0.02;
		
		if (alpha >= 1) {
			info.is_practice = true;
			room_goto(info.reference.scene);
		}
		break;
}

if (global.player_id != 1 || state != -1) {
	exit;
}

var scroll = (global.actions.down.pressed(global.player_id) - global.actions.up.pressed(global.player_id));
var prev_choice = option_selected;

if (option_selected == -1) {
	option_selected = 0;
}

option_selected = (option_selected + array_length(choice_texts) + scroll) % array_length(choice_texts);

if (option_selected != prev_choice) {
	audio_play_sound(global.sound_cursor_move, 0, false);
	
	buffer_seek_begin();
	buffer_write_action(ClientUDP.ChangeChoiceSelected);
	buffer_write_data(buffer_u8, option_selected);
	network_send_udp_packet();
}

if (global.actions.jump.pressed(global.player_id)) {
	start_minigame(option_selected + 1);
	
	buffer_seek_begin();
	buffer_write_action(ClientTCP.MinigameOverviewStart);
	buffer_write_data(buffer_u8, state);
	network_send_tcp_packet();
}