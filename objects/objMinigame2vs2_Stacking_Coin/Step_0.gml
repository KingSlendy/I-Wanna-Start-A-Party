if (following_id != null) {
	exit;
}

grav = (!place_meeting(x, y + grav_amount, objBlock) && !place_meeting(x, y + grav_amount, objMinigame2vs2_Stacking_Coin)) ? grav_amount : 0;

xprevious = x;
yprevious = y;

vspd += grav;
x += hspd;
y += vspd;

if (place_meeting(x, y, objBlock) || place_meeting(x, y, objMinigame2vs2_Stacking_Coin)) {
	x = xprevious;
	y = yprevious;

	//Detect horizontal collision
	if (place_meeting(x + hspd, y, objBlock) || place_meeting(x + hspd, y, objMinigame2vs2_Stacking_Coin)) {
		while (!place_meeting(x + sign(hspd), y, objBlock) && !place_meeting(x + sign(hspd), y, objMinigame2vs2_Stacking_Coin)) {
			x += sign(hspd);
		}
	
	    hspd = 0;
	}

	//Detect vertical collision
	if (place_meeting(x, y + vspd, objBlock) || place_meeting(x, y + vspd, objMinigame2vs2_Stacking_Coin)) {
		while (!place_meeting(x, y + sign(vspd), objBlock) && !place_meeting(x, y + sign(vspd), objMinigame2vs2_Stacking_Coin)) {
			y += sign(vspd);
		}
	
		hspd = 0;
	    vspd = 0;
		grav = 0;
	}

	//Detect diagonal collision
	if (place_meeting(x + hspd, y + vspd, objBlock) || place_meeting(x + hspd, y + vspd, objMinigame2vs2_Stacking_Coin)) {
		hspd = 0;
	}

	x += hspd;
	y += vspd;
}