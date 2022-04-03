if (image_alpha == 0) {
	exit;
}

var prev_glowing = glowing;

if (focused_player().vspeed == 0) {
	glowing = (place_meeting(x, y, objPlayerBase)/* || place_meeting(x, y, objNetworkPlayer)*/);

	if (!prev_glowing && glowing) {
		audio_play_sound(sndSpacePass, 0, false);
	}
}