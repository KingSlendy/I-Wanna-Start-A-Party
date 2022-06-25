if (global.player_id != 1) {
	exit;
}

instance_deactivate_object(objMinigame4vs_Tower_Crack);
instance_deactivate_object(objMinigame4vs_Tower_Trophy);

for (var i = 2; i <= global.player_max; i++) {
	var actions = check_player_actions_by_id(i);

	if (actions == null) {
		continue;
	}
		
	var player = focus_player_by_id(i);
		
	with (player) {
		var check_x = x;
		var check_y = y;
		var me_x = check_x;
		var me_y = check_y;
		
		if (!collision_line(me_x, me_y, me_x, me_y - 32 * 4, all, false, true)) {
			continue;
		}
		
		var decided = false;
		
		for (var j = 0; j < 2; j++) {
			var k = 0;
		
			while (true) {
				if (place_meeting(me_x + 32 * k, me_y, objBlock)) {
					break;
				}
			
				if (!place_meeting(me_x + 32 * k, me_y - 32 * 3, all)) {
					check_x = me_x + 32 * k;
					decided = true;
					break;
				}
			
				k += (j == 0) ? -1 : 1;
			}
		}
		
		if (decided && point_distance(me_x, me_y, check_x, check_y) > 1) {
			var dir = point_direction(me_x, me_y, check_x, check_y);
			var action = (dir == 0) ? actions.right : actions.left;
			action.hold(6);
		}
	}
}

instance_activate_object(objMinigame4vs_Tower_Crack);
instance_activate_object(objMinigame4vs_Tower_Trophy);
alarm[11] = 1;
