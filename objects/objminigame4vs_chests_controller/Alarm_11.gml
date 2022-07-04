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
		if (frozen) {
			break;
		}
		
		if (chest_picked == -1) {
			chest_picked = irandom(3);
		}
		
		var chest = null;
		
		with (objMinigame4vs_Chests_Chest) {
			if (n == other.chest_picked) {
				if (selected == -1) {
					chest = id;
				} else {
					other.chest_picked = -1;
				}
				
				break;
			}
		}
		
		if (chest == null) {
			break;
		}
		
		var me_x = x - 1;
		var me_y = y - 7;
		
		if (place_meeting(x, y, chest)) {
			actions.up.press();
			break;
		}
		
		if (point_distance(me_x, me_y, chest.x, me_y) < 4) {
			break;
		}
		
		var dir = point_direction(me_x, me_y, chest.x, me_y);
		var action = (dir == 0) ? actions.right : actions.left;
		action.press();
	}
}

alarm[11] = 1;