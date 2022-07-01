///@desc Shine Obtain Animation
if (focus_player != null && instance_exists(focus_player)) {
	spawned_shine = instance_create_layer(focus_player.x, focus_player.y, "Actors", objShine);
	spawned_shine.focus_player = focus_player;
}

if (instance_exists(objChooseShine)) {
	audio_play_sound(sndShineSpawn, 0, false);
}

alarm[ShineChangeType.Get] = get_frames(1);