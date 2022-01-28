if (!global.board_started) {
	exit;
}

with (objChooseMinigame) {
	if (zoom) {
		exit;
	}
}

var half_gui_height = display_get_gui_height() / 2;
draw_set_color(c_white);
draw_roundrect(-30, half_gui_height - 30, 70, half_gui_height + 30, false);
draw_set_font(fntPlayerInfo);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_text(35, half_gui_height - 23, "Turn\n" + string(global.board_turn) + "/" + string(global.max_board_turns));