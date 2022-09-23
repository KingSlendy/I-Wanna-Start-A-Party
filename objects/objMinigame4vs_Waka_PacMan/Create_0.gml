image_speed = 0;
image_angle = 270;
max_spd = 10;
intersect = noone;
prev_intersect = null;

function start_path() {
	image_speed = 1;
	image_angle = 270;
	hspeed = 0;
	vspeed = max_spd;
	
	if (!audio_is_playing(sndMinigame4vs_Waka_PacMan)) {
		audio_play_sound(sndMinigame4vs_Waka_PacMan, 0, true);
	}
}