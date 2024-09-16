if (objMinigameController.info.is_finished) {
	exit;
}

image_speed = 1;
minigame2vs2_set_points(other.network_id, other.teammate.network_id);
minigame_finish();