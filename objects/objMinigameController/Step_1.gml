with (objPlayerBase) {
	if (object_index != objNetworkPlayer && !frozen) {
		other.info.player_scores[network_id - 1].timer++;
	}
}

if (!started && instance_number(objPlayerBase)/* + instance_number(objNetworkPlayer)*/ == global.player_max) {
	alpha -= 0.03;
	
	if (alpha <= 0) {
		alpha = 0;
		started = true;
		alarm[0] = get_frames(0.75);
	}
}

if (finished) {
	alpha += 0.03;
	
	if (alpha >= 1) {
		alpha = 1;
		finished = false;
		back_to_board();
	}
}