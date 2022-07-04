if (!is_player_local(other.network_id)) {
	exit;
}

var player_reference = null;

with (objPlayerReference) {
	if (reference == other.reference) {
		player_reference = id;
		break;
	}
}

other.x = player_reference.x + 17;
other.y = player_reference.y + 23;

with (other) {
	state_presses[10] = [5, 0];
	state_presses[13] = [5, 0];
}

audio_play_sound(sndDeath, 0, false);