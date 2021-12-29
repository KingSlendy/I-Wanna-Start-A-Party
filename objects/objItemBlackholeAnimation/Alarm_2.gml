switch (additional) {
	case 0:
		change_coins(-ceil(steal_count), CoinChangeType.Lose);
		break;
		
	case 1:
		change_shines(-1, ShineChangeType.Lose);
		break;
}

global.player_turn = turn_previous;