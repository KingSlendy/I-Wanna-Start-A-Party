enum ItemChangeType {
	None,
	Gain,
	Lose,
	Use
}

event_inherited();
item = null;
spawned_item = null;
used_item = false;
player_turn_info = get_player_turn_info();