with (objPlayerBase) {
	if (object_index == objNetworkPlayer || frozen) {
		break;
	}
	
	if (has_item && distance_to_object(teammate) < other.distance_to_win) {
		with (objMinigame2vs2_Maze_HasItem) {
			if (focus_player == other.teammate) {
				var info = global.minigame_info;
				minigame_2vs2_points(info, other.network_id - 1, other.teammate.network_id - 1, minigame_max_points());
				minigame_finish();
				break;
			}
		}
	}
}