instance_destroy(other.object_index);

if (!is_player_local(other.network_id)) {
	exit;
}

with (focus_player_by_turn(objMinigameController.player_turn)) {
	if (!place_meeting(x, y, objMinigame4vs_Slime_ShootRange)) {
		exit;
	}
}

slime_shot();