if (!is_local_turn() && global.board_started) {
	return;
}

snap_to_object(other);

with (other) {
	box_activate();
}