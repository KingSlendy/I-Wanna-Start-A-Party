if (!cleaned) {
	mp_grid_destroy(grid);

	with (objPlayerBase) {
		path_delete(path);
	}
	
	cleaned = true;
}