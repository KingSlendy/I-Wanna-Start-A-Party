event_inherited();
network_mode = PlayerDataMode.Basic;
xscale = 1;
orientation = 1;
hspd = 0;
vspd = 0;
grav = 0;
max_hspd = 3;
max_vspd = 9;
grav_amount = 0.4;

jump_height = [8.5, 7];
jump_total = 2;

on_block = false;
enable_jump = true;

alarm_create(0, function() {
	sprite_index = skin[$ "Idle"];
});

alarm_create(1, function() {
	var turn = player_info_by_id(network_id).turn - 1;
	
	with (objMinigameController) {
		current_input[turn] += reset_input[turn];
		stall_input[turn] = false;
		reset_input[turn] = 0;
		
		if (current_input[turn] == array_length(input_list) - 1) {
			minigame4vs_points(other.network_id);
			minigame_finish(true);
		}
	}
	
	var block = instance_place(x, y + 1, objBlock);
	
	if (block != noone) {
		with (block) {
			if (image_blend == c_white) {
				image_blend = c_orange;
			}
		}
	
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Leap_Input);
		buffer_write_data(buffer_u8, turn);
		buffer_write_data(buffer_u8, objMinigameController.current_input[turn]);
		buffer_write_data(buffer_s16, block.x);
		buffer_write_data(buffer_s16, block.y);
		network_send_tcp_packet();
	}
});

alarm_frames(0, 1);