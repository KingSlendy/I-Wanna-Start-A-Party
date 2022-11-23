var rnd = random(1);

if (0.3 > rnd) {
	image_speed = 0.4;    
} else if (0.7 > rnd) {
	image_speed = 0.7;
}

if (0.5 > random(1)) {
	image_xscale = -1;
}

if (0.5 > random(1)) {
	image_yscale = -1;
}

if (0.7 > random(1)) {
	sprite_index = sprMinigame4vs_Slime_Effect2;
}