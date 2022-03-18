with (objPlayerBase) {
	if (frozen) {
		break;
	}
	
	if (has_item && distance_to_object(teammate) < other.distance_to_win) {
		with (objMinigame2vs2_Maze_HasItem) {
			if (focus_player == other.teammate) {
				var info = global.minigame_info;
				info.player_scores[other.network_id - 1].points += 1;
				info.player_scores[other.teammate.network_id - 1].points += 1;
				minigame_2vs2_finish();
				break;
			}
		}
	}
}