if (global.player_id != 1) {
	exit;
}

for (var i = 2; i <= global.player_max; i++) {
	var actions = check_player_actions_by_id(i);

	if (actions == null) {
		continue;
	}
	
	with (objMinigame2vs2_Squares_Halfs) {
		if (network_id != i) {
			continue;
		}
		
		if (point_distance(image_angle, 0, 90, 0) <= 6) {
			continue;
		}
		
		if (image_angle < 90) {
		    var action = (abs(image_angle - 90) < 180) ? actions.left : actions.right;
		} else {
			var action = (abs(image_angle - 90) < 180) ? actions.right : actions.left;
		}
		
		action.hold(irandom_range(1, 10));
	}
}

alarm[11] = 5;
