if (roll == 0 && global.dice_roll == 0) {
	instance_destroy();
	exit;
}

if (vspeed != 0 && y > ystart) {
	hspeed = 0;
	vspeed = 0;
	gravity = 0;
	y = ystart;
	alarm_call(0, 0.3);
}

if (follow_target_x && vspeed == 0 && target_x != null) {
	x = lerp(x, target_x, 0.2);
	
	if (point_distance(x, 0, target_x, 0) < 0.01) {
		var full_roll = 0;
		
		with (objDiceRoll) {
			full_roll += roll;
		}
		
		if (!by_item) {
			global.dice_roll = full_roll;
			alarm_frames(0, 1);
		}
		
		target_x = null;
		follow_target_x = false;
	}
}