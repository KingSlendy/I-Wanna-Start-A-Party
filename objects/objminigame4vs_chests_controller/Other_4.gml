event_inherited();

if (trial_is_title(STINGY_CHESTS)) {
	with (objPlayerBase) {
		if (network_id != global.player_id) {
			y = -64;
		}
	}
}