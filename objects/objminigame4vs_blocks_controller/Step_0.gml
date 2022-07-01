var lost_count = 0;

with (objPlayerBase) {
	lost_count += lost;
}

if (lost_count >= global.player_max - 1) {
	with (objMinigame4vs_Blocks_Block) {
		enabled = false;
		active = false;
		image_blend = c_white;
		alarm[0] = 0;
	}
	
	with (objPlayerBase) {
		if (!lost) {
			minigame4vs_points(network_id);
		}
	}
	
	minigame_finish();
}