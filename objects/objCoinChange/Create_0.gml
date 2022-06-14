event_inherited();

enum CoinChangeType {
	None,
	Gain,
	Lose,
	Spend,
	Results,
	Exchange
}

animation_type = CoinChangeType.None;