if (sprite == null) {
	exit;
}

draw_sprite_ext(sprite, 0, display_get_gui_width() / 2, display_get_gui_height() - sprite_get_height(sprite) * 0.5, image_xscale, image_yscale, image_angle, c_white, image_alpha);