if (view_start) {
	view_alpha += 0.1;

	if (view_alpha >= 1) {
		view_alpha = 1;
		view_start = false;
		alarm[1] = get_frames(1);
	}
}
