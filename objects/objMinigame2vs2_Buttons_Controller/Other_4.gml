event_inherited();

grid = mp_grid_create(0, 0, room_width / 32, room_height / 32, 32, 32);
mp_grid_add_instances(grid, objBlock, false);

with (objPlayerBase) {
	jump_total = -1;
	path = path_add();
	jump_delay_timer = 0;
}

if (trial_is_title(CHALLENGE_MEDLEY)) {
	with (objPlayerBase) {
		if (network_id == global.player_id) {
			x = 384 + 17;
			y = 288 + 23;
		} else {
			y = -64;
		}
	}
	
	with (objBlock) {
		if (image_blend == c_red) {
			instance_destroy();
		}
	}
	
	layer_set_visible("Tiles_2", false);
}