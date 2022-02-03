with (objPlayerInfo) {
	if (draw_x < 400) {
		target_draw_x = -draw_w;
	} else {
		target_draw_x = display_get_gui_width();
	}
}

room_goto(rMinigameOverview);