with (objPlayerBase) {
	if (frozen) {
		break;
	}
	
	if (distance_to_object(teammate) < other.distance_to_win && teammate.has_item) {
		minigame_finish(player_info_by_id(network_id).space);
		break;
	}
}