if (instance_exists(objShop) ||
	instance_exists(objBlackhole) ||
	instance_exists(objStatChange) ||
	instance_exists(objItemAnimation) ||
	instance_exists(objBoardHotlandAnnoyingDog)) {
	exit;
}

language_set_font(global.fntDice);
draw_set_alpha(1);
draw_set_color(make_color_rgb(244, 233, 0));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var focus = focused_player();
draw_text_outline((follow_x) ? focus.x : x, (follow_y) ? focus.y - 53 : y, (roll == 0) ? string(global.dice_roll) : roll, c_black);
draw_set_valign(fa_top);
draw_set_halign(fa_left);