with (objPlayerInfo) {
	if (player_info.place == other.displaying) {
		target_draw_x = 400 - draw_w / 2;
	}
}

displaying++;

if (displaying == 5) {
	alarm[2] = get_frames(2);
	exit;
}

alarm[1] = get_frames(0.5);