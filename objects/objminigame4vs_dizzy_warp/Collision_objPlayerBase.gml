if (touched || other.last_touched == id || objMinigameController.info.is_finished) {
	exit;
}

if (is_player_local(other.network_id)) {
	array_shuffle(actions);
		
	with (other) {
		if (!ai) {
			left_action = other.actions[0];
			right_action = other.actions[1];
			jump_action = other.actions[2];
		} else {
			dizzy_delay = get_frames(irandom_range(3, 15));
		}
	}
		
	other.last_touched = id;
}
	
touched = true;
alarm_call(0, 3);
audio_play_sound(sndMinigame4vs_Dizzy_Warp, 0, false);
	
if (other.network_id == global.player_id) {
	trophy = true;
	objMinigameController.trophy_none = false;
}