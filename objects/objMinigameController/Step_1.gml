if (!objPlayerBase.frozen) {
	info.player_scores[global.player_id]++;
}

if (!started && instance_number(objPlayerBase) + instance_number(objNetworkPlayer) == global.player_max) {
	alpha -= 0.03;
	
	if (alpha <= 0) {
		alpha = 0;
		started = true;
		alarm[0] = get_frames(1.5);
	}
}