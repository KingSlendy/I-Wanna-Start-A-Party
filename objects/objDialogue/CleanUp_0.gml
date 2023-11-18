if (sprite_exists(dialogue_sprite)) {
	sprite_delete(dialogue_sprite);
}

if (surface_exists(text_surf)) {
	surface_free(text_surf);
}