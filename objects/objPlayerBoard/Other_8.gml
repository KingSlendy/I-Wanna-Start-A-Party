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
var fasf_space_layer = noone;

with (space) {
	passing = space_passing_event();
	fasf_space_layer = instance_place(x, y, objBoardFASFSpaceLayer);
}

if (passing == 1 || (fasf_space_layer != noone && global.board_fasf_space_mode == FASF_SPACE_MODES.ICE)) {
	exit;
}

if (passing == 0) {
	global.dice_roll = max(global.dice_roll - ((fasf_space_layer == noone || global.board_fasf_space_mode != FASF_SPACE_MODES.MUD) ? 1 : 2), 0);
	
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