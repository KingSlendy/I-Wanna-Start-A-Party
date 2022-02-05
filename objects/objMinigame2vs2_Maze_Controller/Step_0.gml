with (objPlayerBase) {
	if (distance_to_object(teammate) < 10) {
		print("N");
		
		with (objMinigame2vs2_Maze_HasItem) {
			if (focus_player == other.teammate) {
				print("D");
				break;
			}
		}
	}
}