alarms_destroy();

if (surface_exists(surf)) {
	surface_free(surf);
}

if (sprite_exists(broken_sprite)) {
	sprite_delete(broken_sprite);
}