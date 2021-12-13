//Temp
if (keyboard_check_pressed(vk_up)) {
	if (paths.N != null) {
		global.path_current = space.path_north;
		instance_destroy();
	}
}

if (keyboard_check_pressed(vk_right)) {
	if (paths.E != null) {
		global.path_current = space.path_east;
		instance_destroy();
	}
}

if (keyboard_check_pressed(vk_left)) {
	if (paths.W != null) {
		global.path_current = space.path_west;
		instance_destroy();
	}
}

if (keyboard_check_pressed(vk_down)) {
	if (paths.S != null) {
		global.path_current = space.path_south;
		instance_destroy();
	}
}