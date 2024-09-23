if (y < ystart) {
	image_index = 0;
	y = ystart;
	vspd = 0;
}

yprevious = y;

vspd += grav;
y += vspd;

if (place_meeting(x, y, objBlock)) {
	y = yprevious;
	
	if (place_meeting(x, y + vspd, objBlock)) {
		while (!place_meeting(x, y + sign(vspd), objBlock)) {
			y += sign(vspd);
		}
		
		vspd = 0;
		grav = 0;
		
		repeat (3) {
			audio_play_sound(sndMinigame4vs_Crushers_Crusher, 0, false,,, 0.75);
		}
		
		objMinigameController.shake += 5;
		alarm_call(2, 0.75);
	}
}