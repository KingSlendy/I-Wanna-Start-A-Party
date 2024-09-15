//LIVE

language_set_font(global.fntTest);
draw_set_color(c_white)
//draw_text_outline(0, 0, "This is a test message to see the difference in the fonts!\nThis newline shouldn't be that far apart", c_black);

language_set_font(global.fntTitle);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 1; i <= 6; i++) {
	draw_text_transformed_color_outline(title_x, title_y + i, title_text, title_scale, title_scale, 0, c_black, c_black, c_black, c_black, title_alpha, c_ltgray);
}

draw_sprite_ext(title_sprite, 0, title_x, title_y, title_scale, title_scale, 0, c_white, title_alpha);

if (start_visible) {
	press_text.set(language_get_text("TITLE_PRESS", ["{Shift key}", draw_action_big(global.actions.jump)]));
	press_text.draw(292, 500,,, c_lime, c_lime, c_fuchsia, c_fuchsia);
}

language_set_font(global.fntTitleCreator);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_outline(400, 590,  $"{language_get_text("TITLE_MADE")} KINGSLENDY", c_black);
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_text_outline(800, 608, $"v{GM_version}{(!file_exists("test")) ? "" : "t"}", c_black);
draw_set_valign(fa_top);
draw_set_halign(fa_left);