if (current_order == 10) {
	if (objMinigameController.info.player_scores[global.player_id - 1].points == 10) {
		gain_trophy(7);
	}
	
	var empty = true;
	
	with (objMinigame4vs_Magic_Holder) {
		if (network_id == global.player_id && place_meeting(x, y, objMinigame4vs_Magic_Items)) {
			empty = false;
			break;
		}
	}
	
	if (empty) {
		gain_trophy(8);
	}
	
	minigame_finish();
	exit;
}

with (objMinigame4vs_Magic_Holder) {
	if (order == other.current_order) {
		var item = instance_place(x, y, objMinigame4vs_Magic_Items);
		
		if (item != noone && item.order == order) {
			item.state = 0;
			
			if (item.player_turn != 0) {
				minigame4vs_points(item.player.network_id, 1);
			}
		}
	}
}

current_order++;
audio_play_sound(sndMinigame4vs_Magic_Correct, 0, false);
alarm[1] = get_frames(0.8);
