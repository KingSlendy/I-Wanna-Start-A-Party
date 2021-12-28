image_alpha = (!instance_exists(objDice)) ? 1 : 0.2;

if (spawning) {
	image_alpha = lerp(image_alpha, 1, 0.2);
	image_xscale += 0.03;
	image_yscale += 0.03;
	
	if (image_xscale >= 1) {
		image_xscale = 1;
		image_yscale = 1;
	}
	
	y = lerp(y, ystart - 50, 0.1);
	
	if (point_distance(x, y, x, ystart - 50) < 1) {
		spawning = false;
		floating = true;
	}
}

if (getting) {
	image_xscale -= 0.03;
	image_yscale -= 0.03;
	
	if (image_xscale <= 0) {
		objShineChange.alarm[11] = 1;
		instance_destroy();
	}
	
	if (vspeed == 0) {
		audio_play_sound(sndShineGet, 0, false);
	}
	
	vspeed = 1;
}