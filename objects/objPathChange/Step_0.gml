//Temp
if (instance_exists(objMapLook)) {
	exit;
}

if (global.up_action.pressed()) {
	if (paths.N != null) {
		space.space_next = space.space_north;
		instance_destroy();
		exit;
	}
}

if (global.right_action.pressed()) {
	if (paths.E != null) {
		space.space_next = space.space_east;
		instance_destroy();
		exit;
	}
}

if (global.left_action.pressed()) {
	if (paths.W != null) {
		space.space_next = space.space_west;
		instance_destroy();
		exit;
	}
}

if (global.down_action.pressed()) {
	if (paths.S != null) {
		space.space_next = space.space_south;
		instance_destroy();
		exit;
	}
}