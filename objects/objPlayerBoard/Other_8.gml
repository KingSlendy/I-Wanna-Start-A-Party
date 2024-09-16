if (follow_path != null && path_exists(follow_path)) {
	path_delete(follow_path);
	follow_path = null;
}

if (global.dice_roll == -1) {
	global.dice_roll = 0;
	turn_start();
	return;
}

with (objSpaces) {
	space_glow(false);
}

var space = instance_place(x, y, objSpaces);
var passing = 0;

with (space) {
	if (global.board_fasf_space_mode == FASF_SPACE_MODES.ICE && instance_place_any(x, y, objBoardFASFSpaceLayer, function(o) { return (o.image_index + 1 == FASF_SPACE_MODES.ICE); })) {
		board_advance();
		audio_play_sound(sndBoardFASFSpaceLayerIce, 0, false);
		exit;
	}
	
	passing = space_passing_event();
}

if (passing == 1) {
	exit;
}

if (passing == 0) {
	if (global.board_fasf_space_mode != FASF_SPACE_MODES.MUD || !instance_place_any(x, y, objBoardFASFSpaceLayer, function(o) { return (o.image_index + 1 == FASF_SPACE_MODES.MUD); })) {
		global.dice_roll -= 1;
	} else {
		global.dice_roll -= 2;
		audio_play_sound(sndBoardFASFSpaceLayerMud, 0, false);
	}
	
	global.dice_roll = max(global.dice_roll, 0);
	
	with (space) {
		space_glow(true);
	}
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.LessRoll);
		buffer_write_data(buffer_s32, space.x);
		buffer_write_data(buffer_s32, space.y);
		network_send_tcp_packet();
	}
}

if (global.dice_roll > 0) {
	board_advance();
} else {
	with (space) {
		space_finish_event();
	}
	
	has_hit = true;
}