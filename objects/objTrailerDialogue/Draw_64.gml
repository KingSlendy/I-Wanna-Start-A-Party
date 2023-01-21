if (dialogue_sprite == noone) {
	var surf = surface_create(width, height);

	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	draw_box(0, 0, width, height, c_dkgray, c_yellow, 0.8);
	surface_reset_target();

	dialogue_sprite = sprite_create_from_surface(surf, 0, 0, width, height, false, false, 0, 0);
}

draw_sprite_ext(dialogue_sprite, 0, x, y, 1, 1, 0, c_white, image_alpha);

if (!surface_exists(text_surf)) {
	text_surf = surface_create(width - border_width * 2, height);
}

surface_set_target(text_surf);
draw_clear_alpha(c_black, 0);
text_display.text.draw(4, 2, width - border_width * 2);
surface_reset_target();

draw_surface_ext(text_surf, x + border_width, y + border_width, 1, 1, 0, c_white, image_alpha);