if (global.player_id != 1) {
	exit;
}

for (var i = 2; i <= global.player_max; i++) {
	var actions = check_player_actions_by_id(i);

	if (actions == null) {
		continue;
	}
	
	var player = focus_player_by_id(i);
	
	with (player) {
		if (!found && find_timer % 40 == 1 && irandom(1) == 0) {
			var movement = [actions.right, actions.up, actions.left, actions.down];
			movement[irandom(array_length(movement) - 1)].press();
		}
		
		if (--find_timer > 0) {
			continue;
		}
	
		found = true;
		find_timer = get_frames(0.25);
	
		with (objMinigame2vs2_Colorful_Patterns) {
			if (other.x < 400 && x > 400 || other.x > 400 && x < 400) {
				continue;
			}
			
			for (var i = 0; i < pattern_rows * pattern_cols; i++) {
				var r = i div pattern_cols;
				var c = i mod pattern_cols;
				
				if (!pattern_grid[r][c].equals(pattern_chosen)) {
					continue;
				}
				
				var spot = (pattern_player_ids[1] == other.network_id);
				
				if (pattern_selected[!spot] && r == pattern_row_selected[!spot] && c == pattern_col_selected[!spot]) {
					continue;
				}
						
				if (!pattern_selected[spot] && r == pattern_row_selected[spot] && c == pattern_col_selected[spot]) {
					actions.jump.press();
					break;
				}
						
				if (c != pattern_col_selected[spot]) {
					var action = (c < pattern_col_selected[spot]) ? actions.left : actions.right;
					action.press();
				}
						
				if (r != pattern_row_selected[spot]) {
					var action = (r < pattern_row_selected[spot]) ? actions.up : actions.down;
					action.press();
				}
				
				break;
			}
		}
	}
}

alarm[11] = 1;
