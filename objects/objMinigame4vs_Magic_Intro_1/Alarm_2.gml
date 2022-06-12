next_seed_inline();

with (objMinigame4vs_Magic_Items) {
	if (order == other.fall_order[other.fall_current]) {
		hspd = choose(-3, -2, 2, 3);
		grav = random_range(0.1, 0.3);
	}
}

audio_play_sound(sndMinigame4vs_Magic_Fall, 0, false);

if (++fall_current == 10) {
	alarm[3] = get_frames(1);
	exit;
}

alarm[2] = get_frames(0.2);