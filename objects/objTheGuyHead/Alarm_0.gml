with (objTheGuyEye) {
	image_speed = 0;
	image_index = 0;
}

with (objTheGuyMouth) {
	image_speed = 0.5;
	image_index = 0;
}

snd = audio_play_sound(sndTheGuyDestroy, 0, false);

if (is_local_turn()) {
	start_dialogue([
		new Message("What is this!? Another child dares to land in my space!?\nYou'll regret this!",, objTheGuy.show_the_guy_options)
	]);
}
