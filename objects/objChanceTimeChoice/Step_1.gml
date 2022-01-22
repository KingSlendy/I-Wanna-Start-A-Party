x = lerp(x, target_x, 0.2);

if (vspeed != 0 && y > ystart) {
	vspeed = 0;
	gravity = 0;
	y = ystart;
	alarm[0] = get_frames(0.3);
}