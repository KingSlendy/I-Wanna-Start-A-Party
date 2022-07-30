if (!touched && other.last_touched != id) {
	if (is_player_local(other.network_id)) {
		array_shuffle(actions);
		
		with (other) {
			left_action = other.actions[0];
			right_action = other.actions[1];
			jump_action = other.actions[2];
		}
		other.last_touched = id;
	}
	
	touched = true;
	alarm[0] = get_frames(5);
	audio_play_sound(sndMinigame4vs_Dizzy_Warp, 0, false);
	
	if (other.network_id == global.player_id) {
		trophy = true;
	}
}