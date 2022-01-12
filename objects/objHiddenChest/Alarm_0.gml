if (is_player_turn()) {
	if (1 / 20 > random(1)) {
		change_shines(1, ShineChangeType.Spawn).final_action = turn_next;
	} else {
		change_coins(irandom_range(10, 20), CoinChangeType.Gain).final_action = turn_next;
	}
}