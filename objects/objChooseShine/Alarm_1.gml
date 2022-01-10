if (!instance_exists(objShine)) {
	instance_create_layer(space_x + 16, space_y + 16, "Actors", objShine);
	alarm[2] = get_frames(2);
	audio_play_sound(sndShineSpawn, 0, false);
}