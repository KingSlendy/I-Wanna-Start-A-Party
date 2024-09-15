event_inherited();
mp_grid_destroy(grid);

with (objPlayerBase) {
	if (path_exists(path)) {
		path_delete(path);
	}
}