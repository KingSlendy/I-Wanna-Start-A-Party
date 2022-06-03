if (image_alpha == 0) {
	exit;
}

var prev_glowing = glowing;

if (focused_player().vspeed == 0) {
	glowing = place_meeting(x, y, objPlayerBase);
	
	if (instance_exists(objTheGuy)) {
		glowing = false;
	}

	if (!prev_glowing && glowing) {
		audio_play_sound(sndSpacePass, 0, false);
	}
}