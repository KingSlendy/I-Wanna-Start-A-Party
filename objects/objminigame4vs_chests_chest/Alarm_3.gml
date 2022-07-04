if (++total > coins) {
	total = 0;
	exit;
}

instance_create_layer(x, y - 20, "Actors", objMinigame4vs_Chests_CoinDisappear);
minigame4vs_points(selected, 1);
alarm[3] = get_frames(0.25);