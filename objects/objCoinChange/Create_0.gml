event_inherited();

enum CoinChangeType {
	None,
	Gain,
	Lose,
	Spend,
	Give,
	Exchange
}

animation_type = CoinChangeType.None;