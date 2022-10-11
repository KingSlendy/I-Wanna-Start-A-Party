event_inherited();

grid = mp_grid_create(0, 0, room_width / 32, room_height / 32, 32, 32);
mp_grid_add_instances(grid, objBlock, false);
mp_grid_add_instances(grid, objPlatform, false);

with (objPlayerBase) {
	path = path_add();
	jump_delay_timer = 0;
}

objCamera.boundaries = true;