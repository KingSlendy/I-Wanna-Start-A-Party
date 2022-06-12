vspeed = 0;

var time;

switch (place) {
	case 4: time = 2; break;
	case 3: time = 3; break;
	
	case 2:
		time = 5;
		//alarm[0] = get_frames(6.5);
		break;
}

alarm[1] = get_frames(time);
