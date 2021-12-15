//Temp
if (global.up_action.pressed()) {
	if (paths.N != null) {
		global.path_current = space.path_north;
		instance_destroy();
	}
}

if (global.right_action.pressed()) {
	if (paths.E != null) {
		global.path_current = space.path_east;
		instance_destroy();
	}
}

if (global.left_action.pressed()) {
	if (paths.W != null) {
		global.path_current = space.path_west;
		instance_destroy();
	}
}

if (global.down_action.pressed()) {
	if (paths.S != null) {
		global.path_current = space.path_south;
		instance_destroy();
	}
}