event_inherited();

with (objPlayerReference) {
	if (reference == 0) {
		other.x = x + 64 * (other.network_id - 1);
		other.y = y;
	}
}