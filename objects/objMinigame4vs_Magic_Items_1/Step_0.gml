if (state == 0) {
	image_xscale += 0.03;
	image_yscale += 0.03;
	
	if (image_xscale >= 1.5) {
		image_xscale = 1.5;
		image_yscale = 1.5;
		state = 1;
	}
} else if (state == 1) {
	image_xscale -= 0.03;
	image_yscale -= 0.03;
	
	if (image_xscale <= 1) {
		image_xscale = 1;
		image_yscale = 1;
		state = -1;
	}
}

xprevious = x;
yprevious = y;

vspd += grav;
x += hspd;
y += vspd;

var block = instance_place(x, y, objBlock);

if (block != noone) {
	x = xprevious;
	y = yprevious;

	//Detect horizontal collision
	if (place_meeting(x + hspd, y, objBlock)) {
		while (!place_meeting(x + sign(hspd), y, objBlock)) {
			x += sign(hspd);
		}
	
	    hspd = 0;
		vspd = 0;
	}

	//Detect vertical collision
	if (place_meeting(x, y + vspd, objBlock)) {
		while (!place_meeting(x, y + sign(vspd), objBlock)) {
			y += sign(vspd);
		}
	
		hspd = 0;
	    vspd = 0;
		grav = 0;
	}

	//Detect diagonal collision
	if (place_meeting(x + hspd, y + vspd, objBlock)) {
		hspd = 0;
	}

	x += hspd;
	y += vspd;
}
