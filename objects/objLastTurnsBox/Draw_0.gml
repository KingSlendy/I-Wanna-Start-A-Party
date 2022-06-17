draw_sprite_ext(sprBox, 0, x, y - 5, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if (layer_sequence_is_finished(sequence)) {
	if (!surface_exists(surf)) {
		surf = surface_create(32, 32);
	}

	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);

	for (var i = 0; i < array_length(show_sprites); i++) {
		draw_sprite(sprLastTurnsEvents, show_sprites[i], sprite_get_xoffset(sprite), sprite_get_yoffset(sprite) + yy + (32 * i));
	}

	surface_reset_target();

	draw_surface_ext(surf, x - 16, y - 37, image_xscale, image_yscale, 0, c_white, 1);
}

draw_self();