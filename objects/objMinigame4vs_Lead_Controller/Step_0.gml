if (allowed) {
	var player = focus_player_by_turn(other.minigame_turn);
	
	with (objMinigame4vs_Lead_Bubble) {
		x = player.x;
		y = player.y - 15;
	}
	
	if (player.frozen) {
		exit;
	}
	
	for (var i = 0; i < array_length(sequence_actions); i++) {
		if (global.actions[$ sequence_actions[i]].pressed(player.network_id)) {
			objMinigame4vs_Lead_Bubble.action_shown = i;
			audio_play_sound(sndCursorSelect, 0, false);
			
			if (current == array_length(sequence)) {
				correct = true;
				array_push(sequence, i);
				stop_input();
				alarm[4] = get_frames(1);
				break;
			}
			
			if (sequence[current] == i) {
				current++;
			} else {
				stop_input();
				correct = false;
				alarm[4] = get_frames(1);
			}
			
			break;
		}
	}
}
