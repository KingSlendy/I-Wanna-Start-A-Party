if (!frozen) {
	var move_h = (global.actions.right.held(network_id) - global.actions.left.held(network_id));
	var move_v = (global.actions.down.held(network_id) - global.actions.up.held(network_id));

	hspd += move_h * 0.1;
	vspd += move_v * 0.1;
	
	if (move_h != 0) {
		image_xscale = move_h;
	}
}

#region Collision
//Storing the previous x and y
xprevious = x;
yprevious = y;

//Moving the player manually
x += hspd;
y += vspd;

//Collision with block
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
	}

	//Detect vertical collision
	if (place_meeting(x, y + vspd, objBlock)) {
		while (!place_meeting(x, y + sign(vspd), objBlock)) {
			y += sign(vspd);
		}
	
	    vspd = 0;
	}

	//Detect diagonal collision
	if (place_meeting(x + hspd, y + vspd, objBlock)) {
		hspd = 0;
	}

	x += hspd;
	y += vspd;
}
#endregion