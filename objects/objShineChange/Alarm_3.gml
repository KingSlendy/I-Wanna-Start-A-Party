///@desc Shine Obtain Animation
spawned_shine = instance_create_layer(global.shine_spawn_spot.x, global.shine_spawn_spot.y, "Actors", objShine);
audio_play_sound(sndShineSpawn, 0, false);
alarm[ShineChangeType.Get] = get_frames(1);