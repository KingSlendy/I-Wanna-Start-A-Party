depth = (!instance_exists(objTheGuy)) ? -9002 : -9005;
image_alpha = 0;
spawning = true;
floating = false;
y_float = 0;
angle_float = 0;
dir_y_float = 0;
dir_angle_float = 90;
getting = false;
losing = false;
faker = false;

switch (room) {
	case rBoardIsland:
		if (!global.board_day) {
			sprite_index = sprShineNight;
		}
		break;
}