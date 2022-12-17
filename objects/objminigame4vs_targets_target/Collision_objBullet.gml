if (!visible || image_alpha < 1) {
	exit;
}

instance_destroy(other);

if (!is_player_local(other.network_id)) {
	exit;
}

if (other.network_id == global.player_id && !trial_is_title(PERFECT_AIM)) {
	if (objMinigameController.trophy_yellow && sprite == sprMinigame4vs_Targets_TargetYellow) {
		achieve_trophy(47);
	}
	
	objMinigameController.trophy_yellow = false;
}

destroy_target();