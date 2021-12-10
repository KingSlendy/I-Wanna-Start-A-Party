function space_passing_event() {
	switch (image_index) {
		case SpaceType.PathChange:
			if (global.path_direction == 1) {
				switch (get_string("Enter direction", "N")) {
					case "N": global.path_current = path_north; break;
					case "E": global.path_current = path_east; break;
					case "W": global.path_current = path_west; break;
					case "S": global.path_current = path_south; break;
				}
			
				global.path_number = 0;
			}
			return true;
	}
	
	return false;
}

function space_finish_event() {
	switch (image_index) {
		default: break;
	}
}

if (global.debug_mode) {
	if (image_index == SpaceType.PathChange && path_north == null && path_east == null && path_west == null && path_south == null) {
		image_blend = c_red;
	}
}