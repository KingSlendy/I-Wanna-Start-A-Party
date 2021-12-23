if (follow_path != null && path_exists(follow_path)) {
	path_delete(follow_path);
	follow_path = null;
}

if (!global.board_started) {
	global.board_started = true;
	turn_start();
	exit;
}

var space = instance_place(x, y, objSpaces);
var passing = false;

with (space) {
	passing = space_passing_event();
}

if (passing) {
	exit;
}

global.dice_roll--;

buffer_seek_begin();
buffer_write_from_host(false);
buffer_write_action(Client_TCP.LessRoll);
network_send_tcp_packet();

if (global.dice_roll > 0) {
	board_advance();
} else {
	with (space) {
		space_finish_event();
	}
	
	//next_turn();
}