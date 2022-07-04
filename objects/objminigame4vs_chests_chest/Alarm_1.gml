if (++total > coins) {
	total = 0;
	exit;
}

instance_create_layer(x, -20, "Actors", objMinigame4vs_Chests_CoinAppear);
alarm[1] = get_frames(0.25);