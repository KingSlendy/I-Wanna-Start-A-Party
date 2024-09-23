vspd += grav;
x += hspd;
y += vspd;

if ((xstart < 400 && x > 800) || (xstart > 400 && x < -24)) {
	instance_destroy();
	exit;
}

if (y >= 184) {
	y = 184;
	vspd = -7;
}