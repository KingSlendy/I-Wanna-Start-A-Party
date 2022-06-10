image_index = 1;
image_xscale *= -1;
lookout = false;

if (objMinigameController.info.is_finished) {
	exit;
}

music_resume();

if (objMinigameController.state > 1) {
	next_seed_inline();
	alarm[0] = irandom_range(get_frames(2), get_frames(4));
} else {
	objMinigameController.alarm[0] = get_frames(1);
}
