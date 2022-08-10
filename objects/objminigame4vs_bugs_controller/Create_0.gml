with (objPlayerBase) {
	change_to_object(objPlayerStatic);
}

event_inherited();

minigame_time = 30;
minigame_time_end = function() {
	with (objMinigame4vs_Bugs_Bug) {
		hspeed = 0;
		vspeed = 0;
		alarm[0] = 0;
	}
	
	objMinigame4vs_Bugs_Counting.selecting = false;
	
	with (objMinigame4vs_Bugs_Bug) {
		if (sprite_index == other.count_bug) {
			array_push(other.bugs, id);
		}
	}
	
	total_bugs = array_length(bugs);
	minigame_times_up();
	alarm[4] = get_frames(2);
	
	with (objMinigame4vs_Bugs_Counting) {
		if (is_player_local(network_id)) {
			buffer_seek_begin();
			buffer_write_action(ClientTCP.Minigame4vs_Bugs_Counting);
			buffer_write_data(buffer_u8, network_id);
			buffer_write_data(buffer_u8, count);
			network_send_tcp_packet();
		}
	}
}

player_check = objPlayerStatic;
bugs = [];
total_bugs = 0;
draw_top = false;
bug_counter = 0;