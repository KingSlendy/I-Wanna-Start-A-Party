if (phy_speed_previous <= 2 || sound_count <= 10 || hole) {
	exit;
}

sound_count = 0;
audio_play_sound(sndMinigame4vs_Golf_Grass, 0, false);