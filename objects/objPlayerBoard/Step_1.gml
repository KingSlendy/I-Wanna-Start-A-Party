if (vspeed == 0) {
	sprite_index = (follow_path == null) ? sprPlayerIdle : sprPlayerRun;
} else {
	sprite_index = (vspeed < 0) ? sprPlayerJump : sprPlayerFall;
}

if (vspeed > 0 && y >= dice_hit_y) {
	vspeed = 0;
	gravity = 0;
	y = dice_hit_y;
}