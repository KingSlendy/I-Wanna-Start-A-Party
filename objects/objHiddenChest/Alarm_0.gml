if (is_local_turn()) {
	if (1 / 20 > random(1)) {
		change_shines(1, ShineChangeType.Spawn).final_action = turn_next;
		
		if (focused_player().network_id == global.player_id) {
			gain_trophy(4);
		}
	} else {
		change_coins(irandom_range(10, 20), CoinChangeType.Gain).final_action = turn_next;
	}
}