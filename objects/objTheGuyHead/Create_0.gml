depth = -9004;
image_xscale = 40;
image_yscale = 40;
instance_create_layer(x - 45, y + 20, "Actors", objTheGuyEye);
instance_create_layer(x + 85, y + 20, "Actors", objTheGuyEye);

instance_create_layer(x + 20, y + 146, "Actors", objTheGuyMouth);

instance_create_layer(x - 45, y - 20, "Actors", objTheGuyEyebrow);

with (instance_create_layer(x + 85, y - 20, "Actors", objTheGuyEyebrow)) {
	image_xscale *= -1;
}

audio_play_sound(sndTheGuyAaaa, 0, false);
audio_play_sound(sndGlassBreak, 0, false);

snd = null;

alarms_init(1);

alarm_create(function() {
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
			new Message("What is this!? Another child dares to land on my space!?\nYou'll regret this!",, objTheGuy.show_the_guy_options)
		]);
	}
});

alarm_call(0, 2.6);