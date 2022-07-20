function finish_race(giant = true) {
	if (giant) {
		with (objPlayerBase) {
			if (image_xscale > 1) {
				minigame4vs_points(network_id);
			} else {
				hspeed = 0;
			}
			
			objMinigame1vs3_Race_Gradius.hspeed = 0;
		}
	} else {
		with (objPlayerBase) {
			if (image_xscale > 1) {
				hspeed = 0;
			} else {
				minigame4vs_points(network_id);
			}
		}
	}
	
	minigame_finish(true);
	instance_destroy();
}