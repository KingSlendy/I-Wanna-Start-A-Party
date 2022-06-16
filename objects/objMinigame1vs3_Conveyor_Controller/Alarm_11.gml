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
		if (y < 288) {
			if (move_delay_timer > 0) {
				move_delay_timer--;
				break;
			}
			
			if (chosed_conveyor == -1) {
				chosed_conveyor = choose(320, 384, 448) + 16;
			}

			var me_x = x - 1;
			var me_y = y - 7;
			
			if (point_distance(me_x, me_y, chosed_conveyor, me_y) > 3) {
				var dir = floor(point_direction(me_x, me_y, chosed_conveyor, me_y));
				var action = (dir == 0) ? actions.right : actions.left;
				action.hold(6);
			} else {
				actions.jump.hold(15);
				move_delay_timer = irandom_range(get_frames(0.1), get_frames(0.25));
				chosed_conveyor = -1;
			}
		} else {
			switch (objMinigame1vs3_Conveyor_Conveyor.sprite_index) {
				case sprMinigame1vs3_Conveyor_ConveyorStill: var action = null; break;
				case sprMinigame1vs3_Conveyor_ConveyorRight: var action = actions.left; break;
				case sprMinigame1vs3_Conveyor_ConveyorLeft: var action = actions.right; break;
			}
			
			if (action != null) {
				action.hold(irandom_range(2, 6));
			}
		}
	}
}

alarm[11] = 1;
