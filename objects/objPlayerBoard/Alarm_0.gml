event_inherited();

if (!global.board_started) {
	with (objPlayerReference) {
		if (reference == 0) {
			other.x = x + 17 + 64 * (other.network_id - 1);
			other.y = y + 23;
		}
	}
}