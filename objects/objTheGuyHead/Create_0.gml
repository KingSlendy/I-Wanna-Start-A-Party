depth = -10000;
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
alarm[0] = get_frames(2.6);

snd = null;
