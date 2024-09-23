if (objMinigameController.info.is_finished || stacked_id == null || hspd != 0 || vspd != 0) {
	exit;
}

var player = focus_player_by_id(stacked_id.network_id);
minigame2vs2_points(player.network_id, player.teammate.network_id);
minigame_finish(true);