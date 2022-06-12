//If it's not your turn, exit from the event, unless it's the initial turn decisions
if ((!is_local_turn() && global.board_started) || other.focus_player != id) {
	exit;
}

snap_to_object(other);

with (other) {
	box_activate();
}
