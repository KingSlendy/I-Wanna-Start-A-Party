event_inherited();
mp_grid_destroy(grid);
mp_grid_destroy(grid_spikeless);

with (objPlayerBase) {
	if (path_exists(path)) {
		path_delete(path);
	}
}