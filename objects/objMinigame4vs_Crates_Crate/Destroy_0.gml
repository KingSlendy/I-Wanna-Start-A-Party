if (objMinigameController.info.is_finished) {
	exit;
}

with (objMinigameController) {
	crate_create(other.xstart, other.ystart, other.network_id);
}