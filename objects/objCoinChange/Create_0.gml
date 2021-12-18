enum CoinChangeType {
	None,
	Gain,
	Lose,
	Spend,
	Give,
	Exchange
}

player_id = 0;
amount = 0;
animation_type = CoinChangeType.None;
animation_amount = 0;
animation_alpha = 0;
animation_state = 0;
final_action = null;
alarm[0] = 1;