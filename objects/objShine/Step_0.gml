image_alpha = (!place_meeting(x, y, objDice)) ? 1 : 0.2;

if (spawning) {
	image_alpha = lerp(image_alpha, 1, 0.2);
	image_xscale += 0.03;
	image_yscale += 0.03;
	
	if (image_xscale >= 1) {
		image_xscale = 1;
		image_yscale = 1;
	}
	
	y = lerp(y, ystart - 50, 0.1);
	
	if (point_distance(x, y, x, ystart - 50) < 1) {
		spawning = false;
		floating = true;
	}
} else {
	if (losing) {
		image_xscale -= 0.03;
		image_yscale -= 0.03;
	
		if (image_xscale <= 0) {
			if (!faker) {
				if (!instance_exists(objBoardHotlandAnnoyingDog)) {
					with (objShineChange) {
						alarm_frames(11, 1);
					}
				} else {
					with (objBoardHotlandAnnoyingDog) {
						alarm_call(0, 0.5);
					}
				}
			}
			
			with (objItemCloudAnimation) {
				alarm_call(3, 1);
			}
			
			instance_destroy();
		}
	}
}

if (getting) {
	image_xscale -= 0.03;
	image_yscale -= 0.03;
	
	if (image_xscale <= 0) {
		with (objShineChange) {
			alarm_frames(11, 1);
		}
		
		instance_destroy();
	}
	
	vspeed = 1;
}