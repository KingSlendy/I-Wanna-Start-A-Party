if (hole) {
	exit;
}

player_kill();

with (objMinigameController) {
	give_points(other.network_id, 0);
}

hole = true;