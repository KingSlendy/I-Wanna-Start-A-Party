if (following_id != null) {
	exit;
}

var coin_meeting = function(x, y) { return instance_place_any(x, y, objMinigame2vs2_Stacking_Coin, function(o) { return (o.following_id == null); }) };

grav = (!place_meeting(x, y + grav_amount, objBlock) && !coin_meeting(x, y + grav_amount)) ? grav_amount : 0;

xprevious = x;
yprevious = y;

vspd += grav;
x += hspd;
y += vspd;

if (place_meeting(x, y, objBlock) || coin_meeting(x, y) != noone) {
	x = xprevious;
	y = yprevious;

	//Detect horizontal collision
	if (place_meeting(x + hspd, y, objBlock) || coin_meeting(x + hspd, y) != noone) {
		while (!place_meeting(x + sign(hspd), y, objBlock) && coin_meeting(x + sign(hspd), y) == noone) {
			x += sign(hspd);
		}
	
	    hspd = 0;
	}

	//Detect vertical collision
	if (place_meeting(x, y + vspd, objBlock) || coin_meeting(x, y + vspd) != noone) {
		while (!place_meeting(x, y + sign(vspd), objBlock) && coin_meeting(x, y + sign(vspd)) == noone) {
			y += sign(vspd);
		}
	
		hspd = 0;
	    vspd = 0;
		grav = 0;
	}

	//Detect diagonal collision
	if (place_meeting(x + hspd, y + vspd, objBlock) || coin_meeting(x + hspd, y + vspd) != noone) {
		hspd = 0;
	}

	x += hspd;
	y += vspd;
}