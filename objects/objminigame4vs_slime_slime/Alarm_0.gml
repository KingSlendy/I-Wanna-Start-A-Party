next_seed_inline();
var lost_count = 0;

with (objPlayerBase) {
	lost_count += lost;	
}

image_index = (1 / (5 - lost_count) > random(1)) ? 1 : 3;

if (image_index == 3) {
	audio_play_sound(sndMinigame4vs_Slime_Mercy, 0, false);
} else {
	instance_create_layer(x + sprite_width / 2, y - 20, "Actors", objMinigame4vs_Slime_Laser);
	audio_play_sound(sndMinigame4vs_Slime_Laser, 0, false);
}

alarm[1] = get_frames(2);