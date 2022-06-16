ang = 0;
lookout = false;
player_targets = [];
target_x = x;
target_y = y;
target_player = null;
targeting = false;
returning = false;

function start_target_player() {
	if (alarm[3] == -1) {
		alarm[0] = 0;
		alarm[1] = 0;
		alarm[2] = 0;
		alarm[3] = get_frames(1);
		targeting = true;
	}
}

function next_target_player() {
	if (objMinigameController.info.is_finished) {
		return;
	}
	
	if (array_length(player_targets) == 0) {
		target_player = null;
		target_x = xstart;
		target_y = ystart;
		returning = true;
		return;
	}
	
	var min_dist = infinity;
	
	for (var i = 0; i < array_length(player_targets); i++) {
		var player = focus_player_by_id(player_targets[i]);
		min_dist = min(min_dist, point_distance(x, y, player.x, player.y));
	}
	
	for (var i = 0; i < array_length(player_targets); i++) {
		var player = focus_player_by_id(player_targets[i]);
		
		if (point_distance(x, y, player.x, player.y) == min_dist) {
			target_player = player;
			target_x = player.x;
			target_y = player.y;
			array_delete(player_targets, i, 1);
			break;
		}
	}
}
