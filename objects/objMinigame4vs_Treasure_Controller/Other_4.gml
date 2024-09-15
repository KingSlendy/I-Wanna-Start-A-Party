event_inherited();
next_seed_inline();
var treasure_x = 32 * choose(1, 16);

with (instance_create_layer(treasure_x + irandom_range(0, 7) * 32, 32 + irandom_range(0, 16) * 32, "Actors", objMinigame4vs_Treasure_Treasure)) {
	depth = layer_get_depth("Collisions") + 1;
}

grid = mp_grid_create(0, 0, room_width / 32, room_height / 32, 32, 32);
mp_grid_add_instances(grid, objBlock, false);

with (objPlayerBase) {
	path = path_add();
}