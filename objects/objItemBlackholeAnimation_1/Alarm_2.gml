steal_count = ceil(steal_count);
state = -2;

switch (additional) {
	case 0:
		if (!stealed) {
			var c = change_coins(steal_count * -1, CoinChangeType.Lose, global.choice_selected + 1);
		} else {
			var c = change_coins(steal_count * -1, CoinChangeType.Gain);
		}
		
		c.final_action = end_blackhole_steal;
		break;
		
	case 1:
		if (!stealed) {
			var s = change_shines(sign(steal_count * -1), ShineChangeType.Lose, global.choice_selected + 1);
		} else {
			var s = change_shines(sign(steal_count * -1), ShineChangeType.Spawn);
		}
		
		s.final_action = end_blackhole_steal;
		break;
}