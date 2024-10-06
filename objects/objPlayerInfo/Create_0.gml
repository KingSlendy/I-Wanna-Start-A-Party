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
controls_text = new Text(global.fntControls);

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

function can_controls() {
	return (global.board_started && !instance_exists(objMapLook) && !instance_exists(objChooseMinigame) && !instance_exists(objResultsMinigame) && !instance_exists(objLastTurns));
}

function can_react() {
	return (
		player_info.turn != global.player_turn &&
		reaction_target == 0 &&
		reaction_alpha == 0
	);
}

function can_map() {
	var player = focused_player();
	return (
		player_info.turn == global.player_turn &&
		player.object_index == objPlayerBoard &&
		!player.has_hit &&
		player.follow_path == null &&
		!instance_exists(objDice) &&
		!instance_exists(objHiddenChest) &&
		!instance_exists(objStatChange) &&
		!instance_exists(objItemAnimation) &&
		!instance_exists(objChooseShine) &&
		!instance_exists(objBoardHotlandAnnoyingDog) &&
		!instance_exists(objBoardPalletObtain) &&
		!instance_exists(objBoardPalletBattle) &&
		!instance_exists(objBoardWorldShuffle)
	);
}

function reaction(index) {
	reacted = index;
	reaction_alpha = 0;
	reaction_target = 1;
	reaction_scale = 1;
	reactions = false;
	var react = global.reactions[index];
	
	if (react.sound != null) {
		audio_play_sound(react.sound, 0, false);
	}
			
	alarm[0] = get_frames(2);
	
	if (player_info.network_id == global.player_id) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Reaction);
		buffer_write_data(buffer_u8, player_info.network_id);
		buffer_write_data(buffer_u8, index);
		network_send_tcp_packet();
	}
}