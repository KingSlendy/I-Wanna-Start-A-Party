if (enabled && !active && !place_meeting(x, y, objBlock) && place_meeting(x, y - 1, objPlayerBase)) {
	image_blend = c_red;
	alarm_call(0, 1);
	active = true;
}