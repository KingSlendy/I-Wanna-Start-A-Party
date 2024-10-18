event_inherited();

if (surface_exists(surf)) {
	surface_free(surf);
}

if (sprite_exists(spotlight)) {
	sprite_delete(spotlight);
}

mp_grid_destroy(grid);

with (objPlayerBase) {
	if (path_exists(path)) {
		path_delete(path);
	}
}