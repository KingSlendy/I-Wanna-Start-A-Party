if (!global.show_dice_roll && global.dice_roll > 0) {
	exit;
}

draw_set_font(fntDice);
draw_set_alpha(1);
draw_set_color(make_color_rgb(244, 233, 0));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var focus = focused_player_turn();
draw_text_outline(focus.x, (follow_y) ? focus.y - 53 : y, string(global.dice_roll), c_black);
draw_set_valign(fa_top);
draw_set_halign(fa_left);