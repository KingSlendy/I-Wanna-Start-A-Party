if (abs(speed) >= 1) {
    speed *= -0.25;
}

x = xprevious;
y = yprevious;

if (network_id == global.player_id && other.object_index == objMinigame4vs_Karts_Pipe) {
	other.bumped = true;
	var all_pipes_bumped = true;
	
	with (objMinigame4vs_Karts_Pipe) {
		if (!bumped) {
			all_pipes_bumped = false;
		}
	}
	
	if (all_pipes_bumped) {
		achieve_trophy(89);
	}
}