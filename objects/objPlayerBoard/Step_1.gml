if (!dice_hitting) {
	sprite_index = (follow_path == null) ? sprPlayerIdle : sprPlayerRun;
} else {
	sprite_index = (vspeed < 0) ? sprPlayerJump : sprPlayerFall;
}

if (dice_hitting && y >= dice_hit_y) {
	vspeed = 0;
	gravity = 0;
	y = dice_hit_y;
	dice_hitting = false;
}