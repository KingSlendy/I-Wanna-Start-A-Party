if (!instance_exists(objShine)) {
	instance_create_layer(space_x + 16, space_y + 16, "Actors", objShine);
	alarm[2] = game_get_speed(gamespeed_fps) * 2;
}