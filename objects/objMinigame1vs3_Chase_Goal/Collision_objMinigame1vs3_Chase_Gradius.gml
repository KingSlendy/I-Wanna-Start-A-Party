if (!other.broke) {
	with (objPlayerBase) {
		if (image_xscale > 1) {
			hspeed = 0;
		} else {
			minigame4vs_points(network_id);
		}
	}
	
	minigame_finish(true);
}

instance_destroy();
