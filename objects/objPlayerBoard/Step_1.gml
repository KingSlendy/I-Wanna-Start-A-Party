if (global.board_started) {
	if (player_info_by_turn(global.player_turn).network_id != network_id) {
		depth = 0;
	} else {
		depth = -1;
	}
}

if (vspeed == 0) {
	sprite_index = (follow_path == null) ? skin[$ "Idle"] : skin[$ "Run"];
} else {
	sprite_index = (vspeed < 0) ? skin[$ "Jump"] : skin[$ "Fall"];
}

if (vspeed > 0 && y >= dice_hit_y) {
	vspeed = 0;
	gravity = 0;
	y = dice_hit_y;
}