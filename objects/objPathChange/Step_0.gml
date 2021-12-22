//Temp
if (instance_exists(objMapLook)) {
	exit;
}

if (global.up_action.pressed()) {
	if (paths.N != null) {
		global.path_current = space.path_north;
		instance_destroy();
		exit;
	}
}

if (global.right_action.pressed()) {
	if (paths.E != null) {
		global.path_current = space.path_east;
		instance_destroy();
		exit;
	}
}

if (global.left_action.pressed()) {
	if (paths.W != null) {
		global.path_current = space.path_west;
		instance_destroy();
		exit;
	}
}

if (global.down_action.pressed()) {
	if (paths.S != null) {
		global.path_current = space.path_south;
		instance_destroy();
		exit;
	}
}