next_seed_inline();

if (coin_count++ % 2 == 0) {
	var c = instance_create_layer(496, 256, "Collectables", objMinigame1vs3_Coins_Coin);
} else {
	var c = instance_create_layer(720, 256, "Collectables", objMinigame1vs3_Coins_Coin);
}

c.hspeed = choose(-1, 1);

alarm[4] = get_frames(0.6);