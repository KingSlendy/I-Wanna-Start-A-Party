x = approach(x, target_x, 10);
y = approach(y, target_y, 10);

if (x == target_x && y == target_y) {
	if (target_player != null) {
		with (target_player) {
			player_kill();
		}
		
		target_player = null;
		next_target_player();
	}
	
	if (returning) {
		with (objPlayerBase) {
			if (!lost && !won) {
				frozen = false;
			}
		}
		
		event_perform(ev_alarm, 2);
		player_targets = [];
		targeting = false;
		returning = false;
	}
}
