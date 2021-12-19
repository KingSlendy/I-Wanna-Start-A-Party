///@desc Shine Obtain Animation
spawned_shine = instance_create_layer(objHiddenChest.x + 16, objHiddenChest.y + 16, "Actors", objShine);
audio_play_sound(sndShineSpawn, 0, false);
alarm[ShineChangeType.Get] = game_get_speed(gamespeed_fps) * 1;