if (!show_input || info.is_finished) {
	exit;
}

for (var i = 0; i < global.player_max; i++) {
	var player = focus_player_by_turn(i + 1);
	
	if (!is_player_local(player.network_id)) {
		continue;
	}
	
	var input = input_list[current_input[i]];
	//var index = array_get_index(input_actions, input);
	//input_buffers[i][index]--;
	//input_buffers[i][index] = max(input_buffers[i][index], 0);
	
	for (var j = 0; j < array_length(input_actions); j++) {
		var action = input_actions[j];

		if (stall_input[i]/* || input_buffers[i][index] == 0*/) {
			continue;
		}
		
		if (global.actions[$ action].pressed(player.network_id)) {
			var was_correct = false;
			
			if (input == action) {
				was_correct = true;
			}
			
			if (!was_correct && current_input[i] == 0) {
				break;
			}

			with (player) {
				if (on_block) {
					if (was_correct) {
						hspd = 4;
						other.reset_input[i] = 1;
						audio_play_sound(sndMinigame4vs_Leap_Correct, 0, false);
					} else {
						hspd = -4;
						other.reset_input[i] = -1;
						audio_play_sound(sndMinigame4vs_Leap_Wrong, 0, false);
					}
				
					vspd = -5;
					other.stall_input[i] = true;
				}
			}
		}
	}
}