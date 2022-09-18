draw_self();
draw_set_font(fntMinigame1vs3_Showdown_Block);
draw_set_color(#480017);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(x + sprite_width / 2, y + sprite_height / 2, (!selecting && number >= 0) ? number + 1 : "?", image_xscale, image_yscale, 0);
draw_set_valign(fa_top);

if (selecting) {
	draw_set_font(fntMinigame1vs3_Showdown_Select);
	draw_set_color(c_black);
	var text = new Text(fntMinigame1vs3_Showdown_Select, "{SPRITE," + sprite_get_name(global.actions.left.bind()) + ",0,0,5,0.35,0.35} " + string(show + 1) + " {SPRITE," + sprite_get_name(global.actions.right.bind()) + ",0,1,5,0.35,0.35}");
	text.draw(x + sprite_width / 2 - 40, y + sprite_height + 5);
}

draw_set_halign(fa_left);