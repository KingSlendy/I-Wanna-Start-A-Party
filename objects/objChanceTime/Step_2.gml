if (!started) {
	exit;
}

for (var i = 1; i <= global.player_max; i++) {
	with (focus_player_by_turn(i)) {
		draw = (id == other.focus_player || (array_contains(other.player_ids, i - 1) && other.show_others));
	}
}