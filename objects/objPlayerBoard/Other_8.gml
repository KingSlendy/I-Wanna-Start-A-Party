if (follow_path != null && path_exists(follow_path)) {
	path_delete(follow_path);
	follow_path = null;
}

if (global.board_first_space[network_id - 1]) {
	global.dice_roll = 0;
	global.board_first_space[network_id - 1] = false;
	turn_start();
	return;
}

with (objSpaces) {
	space_glow(false);
}

var space = instance_place(x, y, objSpaces);
var passing = false;

with (space) {
	passing = space_passing_event();
}

if (passing == 1) {
	exit;
}

if (passing == 0) {
	global.dice_roll--;
	
	with (space) {
		space_glow(true);
	}
	
	buffer_seek_begin();
	buffer_write_action(ClientTCP.LessRoll);
	buffer_write_data(buffer_s32, space.x);
	buffer_write_data(buffer_s32, space.y);
	network_send_tcp_packet();
}

if (global.dice_roll > 0) {
	board_advance();
} else {
	with (space) {
		space_finish_event();
	}
	
	//turn_next();
}