if (!IS_BOARD || !global.board_started || global.minigame_info.is_finished) {
	exit;
}

with (objChooseMinigame) {
	if (zoom) {
		exit;
	}
}

var size = 30;
var half_gui_height = display_get_gui_height() / 2 - 64;
draw_set_color(c_white);
draw_roundrect(-30, half_gui_height - size, 80, half_gui_height + size, false);
draw_set_font(fntPlayerInfo);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_text(40, half_gui_height - 23, language_get_text("PARTY_TURN") + "\n" + string(global.board_turn) + "/" + string(global.max_board_turns));