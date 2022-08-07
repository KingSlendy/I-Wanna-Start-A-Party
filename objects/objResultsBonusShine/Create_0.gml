image_speed = 0;
image_xscale = 0;
image_yscale = 0;
increase = true;
bonus = null;
dir_y_float = 0;
dir_angle_float = 90;

function go_up() {
	vspeed = -8;
	alarm[0] = get_frames(2);
	
	if (global.player_id == 1) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ResultsBonusShineGoUp);
		network_send_tcp_packet();
	}
}

function next_bonus() {
	with (objResults) {
		results_bonus();	
	}
			
	instance_destroy();
	
	if (global.player_id == 1) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ResultsBonusShineNextBonus);
		network_send_tcp_packet();
	}
}