if (info.is_finished) {
	exit;
}

for (var i = 0; i < global.player_max; i++) {
	var input = input_list[current_input[i]];
	var index = array_get_index(input_actions, input);
	input_buffers[i][index]--;
	input_buffers[i][index] = max(input_buffers[i][index], 0);
	var player = focus_player_by_turn(i + 1);
	
	if (global.actions[$ input].pressed(player.network_id)) {
		input_buffers[i][index] = 15;
	}
	
	if (stall_input[i] || input_buffers[i][index] == 0) {
		continue;
	}
	
	with (player) {
		if (on_block) {
			hspd = 4;
			//vspd = -5.012;
			vspd = -5;
			other.stall_input[i] = true;
			other.reset_input[i] = true;
		}
	}
}