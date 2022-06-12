if (global.player_id != 1) {
	exit;
}

for (var i = 2; i <= global.player_max; i++) {
	if (!instance_exists(objMinigame2vs2_Fruits_Fruit)) {
		break;
	}
	
	var actions = check_player_actions_by_id(i);

	if (actions == null) {
		continue;
	}
		
	var player = focus_player_by_id(i);
		
	with (player) {
		if (move_delay_timer > 0) {
			move_delay_timer--;
			break;
		}
		
		var me_x = x - 1;
		var me_y = y - 7;
		var near = instance_nearest(me_x, me_y, objMinigame2vs2_Fruits_Fruit);
		var check_x = near.x;
		
		if (point_distance(me_x, me_y, check_x, me_y) > 1) {
			var dir = point_direction(me_x, me_y, check_x, me_y);
			var action = (dir == 0) ? actions.right : actions.left;
			action.hold(6);
		}
		
		if (0.05 > random(1)) {
			move_delay_timer = irandom_range(get_frames(0.5), get_frames(2));
		}
	}
}

alarm[11] = 1;
