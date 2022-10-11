event_inherited();

grid_size = 32;
grid = mp_grid_create(0, 0, room_width / grid_size, room_height / grid_size, grid_size, grid_size);
mp_grid_add_instances(grid, objBlock, false);
mp_grid_add_instances(grid, objMinigame4vs_Bubble_Spike, true);

grid_spikeless = mp_grid_create(0, 0, room_width / grid_size, room_height / grid_size, grid_size, grid_size);
mp_grid_add_instances(grid_spikeless, objBlock, false);

with (objPlayerBase) {
	path = path_add();
}