if (is_player_turn()) {
	if (1 / 20 > random(1)) {
		var s = change_shines(1, ShineChangeType.Spawn);
		s.spawn_instance = id;
		s.final_action = turn_next;
	} else {
		change_coins(irandom_range(10, 20), CoinChangeType.Gain).final_action = turn_next;
	}
}