event_inherited();
surface_free(surf);
sprite_delete(spotlight);
mp_grid_destroy(grid);

with (objPlayerBase) {
	if (path_exists(path)) {
		path_delete(path);
	}
}