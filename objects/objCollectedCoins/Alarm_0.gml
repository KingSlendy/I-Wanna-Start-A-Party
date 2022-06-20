var increase = 1;

if (amount - current > 100) {
	increase = 100;
}

coins += increase;
scale = (scale == 1) ? 1.25 : 1;
audio_play_sound(sndCoinGet, 0, false);
current += increase;

if (current == amount) {
	alarm[1] = get_frames(1);
	exit;
}

alarm[0] = 3;
