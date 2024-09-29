event_inherited();

with (objCamera) {
	lock_y = true;
	boundaries = true;
	camera_correct_position(id);
}

if (trial_is_title(CHALLENGE_MEDLEY)) {
	layer_set_visible("Background_2", true);
	
	with (objMinigameController) {
		depth = layer_get_depth("Background_2") - 1;
	}
	
	with (objMinigame2vs2_Duos_Warp) {
		depth = layer_get_depth("Background_2") - 1;
	}
}