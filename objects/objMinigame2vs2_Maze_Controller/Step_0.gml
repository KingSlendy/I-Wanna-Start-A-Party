with (objPlayerBase) {
	if (!is_player_local(network_id)|| frozen) {
		break;
	}
	
	if (has_item && distance_to_object(teammate) < other.distance_to_win) {
		with (objMinigame2vs2_Maze_HasItem) {
			if (focus_player == other.teammate) {
				var info = global.minigame_info;
				minigame_2vs2_points(info, other.network_id, other.teammate.network_id);
				minigame_finish(true);
				break;
			}
		}
	}
}