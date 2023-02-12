event_inherited();

if (trial_is_title(GREEN_DIVING)) {
	with (objPlayerBase) {
		if (network_id != global.player_id) {
			y = -64;
		}
	}
}