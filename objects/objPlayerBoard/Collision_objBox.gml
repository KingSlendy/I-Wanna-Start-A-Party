if (!is_local_turn()) {
	return;
}

snap_to_object(other);

with (other) {
	box_activate();
}