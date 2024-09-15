with (objPlayerBase) {
	if (!is_player_local(network_id) || frozen) {
		break;
	}
	
	if (has_item && distance_to_object(teammate) < other.distance_to_win) {
		with (objMinigame2vs2_Maze_HasItem) {
			if (focus_player == other.teammate) {
				minigame2vs2_points(other.network_id, other.teammate.network_id);
				minigame_finish(true);
				audio_play_sound(sndMinigame2vs2_Maze_Assembly, 0, false, 1, 0, 1);
				
				break;
			}
		}
	}
	
	if (network_id == global.player_id && point_distance(x, y, xstart, ystart) >= 1490) {
		achieve_trophy(27);
	}
}