if (global.dice_roll > 0) {
	var player = focus_player();
	draw_set_color(c_black);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(player.x, player.y - 40, string(global.dice_roll));
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}