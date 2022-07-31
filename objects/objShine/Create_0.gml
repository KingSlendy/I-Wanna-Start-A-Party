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

if (room == rBoardIsland && !global.board_day) {
	sprite_index = sprShineNight;
}

if (room == rBoardPalletTown && global.shine_power_type != ShinePowerType.None) {
	switch (global.shine_power_type) {
		case ShinePowerType.Fire: sprite_index = sprShineFire; break;
		case ShinePowerType.Grass: sprite_index = sprShineGrass; break;
		case ShinePowerType.Pshycic: sprite_index = sprShinePsychic; break;
	}
}