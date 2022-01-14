steal_count = -ceil(steal_count);
state = -2;

switch (additional) {
	case 0:
		change_coins(steal_count, (!stealed) ? CoinChangeType.Lose : CoinChangeType.Gain).final_action = end_blackhole_steal;
		break;
		
	case 1:
		change_shines(sign(steal_count), (!stealed) ? ShineChangeType.Lose : ShineChangeType.Spawn).final_action = end_blackhole_steal;
		break;
}