event_inherited();
mp_grid_destroy(grid);

with (objPlayerBase) {
	if (path_exists(path)) {
		path_delete(path);
	}
}

part_emitter_destroy_safe(part_system, part_emitter);
part_type_destroy_safe(part_type);
part_system_destroy_safe(part_system);