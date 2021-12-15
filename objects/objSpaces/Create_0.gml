if (global.debug_mode) {
	if (image_index == SpaceType.PathChange && path_north == null && path_east == null && path_west == null && path_south == null) {
		image_blend = c_red;
	}
}

space_shine = false;

if (image_index == SpaceType.Shine) {
	space_shine = true;
	image_index = SpaceType.Blue;
}

function space_passing_event() {
	switch (image_index) {
		case SpaceType.Shine:
			if (get_player_info().coins >= 20) {
				change_coins(-20);
				change_shines(1);
				global.shine_spotted = false;
				choose_shine();
			}
			return false;
		
		case SpaceType.PathChange:
			if (global.path_direction == 1) {
				var p = instance_create_layer(0, 0, "Managers", objPathChange);
				p.space = id;
			}
			
			global.path_number = 0;
			return true;
	}
	
	return false;
}

function space_finish_event() {
	switch (image_index) {
		case SpaceType.Blue:
			change_coins(3);
			break;
			
		case SpaceType.Red:
			change_coins(-3);
			break;
			
		default: break;
	}
}