var player = other;

if (image_index == 0) {
	with (object_index) {
		if (image_index == 1) {
			player.x = x + 17;
			player.y = y + 23;
			audio_play_sound(sndMinigame1vs3_Warping_Warp, 0, false);
			break;
		}
	}
}