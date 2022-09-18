if (image_xscale < 3.5 || other.touched || objMinigameController.info.is_finished) {
	exit;
}

if (image_index == 0 || image_index == 1) {
	minigame4vs_points(other.network_id, 1);
	audio_play_sound(sndMinigamePointsA, 0, false);
} else if (minigame4vs_get_points(other.network_id) > 0) {
	minigame4vs_points(other.network_id, -1);
	audio_play_sound(sndMinigamePointsF, 0, false);
}

other.touched = true;
instance_destroy();