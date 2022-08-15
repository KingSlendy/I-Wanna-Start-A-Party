switch (state) {
	case 0:
		if (get_player_count(objPlayerBase) == global.player_max) {
			fade_alpha -= 0.03;
			music_play(bgmMinigameOverview);
		
			if (fade_alpha <= 0) {
				fade_alpha = 0;
				state = -1;
			}
		}
		break;
		
	case 1:
		fade_alpha += 0.02;
		
		if (fade_alpha >= 1) {
			info.is_practice = false;
			room_goto(info.reference.scene);
		}
		break;
		
	case 2:
		fade_alpha += 0.02;
		
		if (fade_alpha >= 1) {
			info.is_practice = true;
			room_goto(info.reference.scene);
		}
		break;
		
	case 3:
		fade_alpha += 0.02;
		
		if (fade_alpha >= 1) {
			disable_board();
			room_goto(rMinigames);
		}
		break;
}

if (state != -1) {
	exit;
}

var scroll_h = (global.actions.right.pressed(global.player_id) - global.actions.left.pressed(global.player_id));
var prev_page = instructions_page;
instructions_page = (instructions_page + array_length(instructions) + scroll_h) % array_length(instructions);

if (instructions_page != prev_page) {
	//audio_play_sound(global.sound_cursor_move, 0, false);
}

if (global.player_id != 1) {
	exit;
}

var scroll_v = (global.actions.down.pressed(global.player_id) - global.actions.up.pressed(global.player_id));
var prev_choice = option_selected;

if (option_selected == -1) {
	option_selected = 0;
}

option_selected = (option_selected + array_length(choice_texts) + scroll_v) % array_length(choice_texts);

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

if (info.is_modes && global.actions.shoot.pressed(global.player_id)) {
	state = 3;
	audio_play_sound(global.sound_cursor_back, 0, false);
	
	buffer_seek_begin();
	buffer_write_action(ClientTCP.MinigameOverviewStart);
	buffer_write_data(buffer_u8, state);
	network_send_tcp_packet();
}