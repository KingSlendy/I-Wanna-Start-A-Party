if (room == rParty) {
	visible = false;
	persistent = false;
}

depth = -9000;
player_info = null;
draw_w = 230;
draw_h = 90;
reactions = false;
page = 0;
selected = 0;
reacted = -1;
reaction_alpha = 0;
reaction_scale = 0;
reaction_target = 0;
reaction_text = new Text(fntControls);

function setup() {
	player_idle_image = get_skin_pose_object(focus_player_by_id(player_info.network_id), "Idle");
	draw_x = 0;
	draw_y = 0;

	switch (player_info.turn) {
		case 1:
			draw_x = 0;
			draw_y = 0;
			break;
		
		case 2:
			draw_x = display_get_gui_width() - draw_w;
			draw_y = 0;
			break;
		
		case 3:
			draw_x = 0;
			draw_y = display_get_gui_height() - draw_h;
			break;
		
		case 4:
			draw_x = display_get_gui_width() - draw_w;
			draw_y = display_get_gui_height() - draw_h;
			break;
	}

	target_draw_x = draw_x;
	target_draw_y = draw_y;
	main_draw_x = draw_x;
	main_draw_y = draw_y;

	if (draw_x < 400) {
		draw_x -= draw_w;
	} else {
		draw_x += draw_w;
	}
}

function can_react() {
	return (global.board_started && global.player_turn != player_info.turn && !instance_exists(objChooseMinigame) && !instance_exists(objResultsMinigame));
}

function reaction(index) {
	reacted = index;
	reaction_alpha = 0;
	reaction_target = 1;
	reaction_scale = 1;
	reactions = false;
	//var sounds = [null, null, null, null, null, null, null, null, null, null];
	//var sound = sounds[index];
			
	//if (sound != null) {
	//	audio_play_sound(sound, 0, false);
	//}
			
	alarm[0] = get_frames(2);
	
	if (player_info.network_id == global.player_id) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Reaction);
		buffer_write_data(buffer_u8, player_info.network_id);
		buffer_write_data(buffer_u8, index);
		network_send_tcp_packet();
	}
}