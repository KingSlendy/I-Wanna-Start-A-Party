if (is_local_turn()) {
	if (1 / 20 > random(1)) {
		var s = change_shines(1, ShineChangeType.Spawn);
		s.focus_player = {x: self.x + 16, y: self.y + 16};
		s.final_action = turn_next;
	} else {
		var c = change_coins(irandom_range(10, 20), CoinChangeType.Gain);
		c.focus_player = {x: self.x + 16, y: self.y + 16};
		c.final_action = turn_next;
	}
}