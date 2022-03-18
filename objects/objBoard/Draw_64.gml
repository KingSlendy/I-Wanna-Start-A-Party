//The next statement never gets triggered because with the Ctrl shortcut board never starts
if (!IS_BOARD || !global.board_started) {
	exit;
}

if (from_minigame) {
	draw_set_alpha(from_minigame_alpha);
	draw_set_color(c_black);
	draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
	draw_set_alpha(1);
}

with (objChooseMinigame) {
	if (zoom) {
		exit;
	}
}

var half_gui_height = display_get_gui_height() / 2;
draw_set_color(c_white);
draw_roundrect(-30, half_gui_height - 30, 80, half_gui_height + 30, false);
draw_set_font(fntPlayerInfo);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_text(40, half_gui_height - 23, "Turn\n" + string(global.board_turn) + "/" + string(global.max_board_turns));