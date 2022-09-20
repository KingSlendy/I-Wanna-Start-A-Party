event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_shoot = false;
		move_delay_timer = 0;
		chosed_conveyor = -1;
	}
}

minigame_time = 20;
minigame_time_end = function() {
	if (!minigame1vs3_lost()) {
		minigame1vs3_points();
	} else {
		minigame4vs_points(points_teams[1][0].network_id);
	}
	
	minigame_finish();
}

action_end = function() {
	with (objMinigame1vs3_Conveyor_Conveyor) {
		sprite_index = sprMinigame1vs3_Conveyor_ConveyorStill;
		spd = 0;
	}
}

player_check = objPlayerPlatformer;

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
	
		with (player) {
			var me_x = x - 1;
			var me_y = y - 7;
		
			if (y < 288) {
				if (move_delay_timer > 0) {
					move_delay_timer--;
					break;
				}
			
				if (chosed_conveyor == -1) {
					chosed_conveyor = choose(320, 384, 448) + 16;
				}
			
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
					action.hold(irandom_range(get_frames(0.1), get_frames(0.2)));
				} else {
					var dist = point_distance(me_x, me_y, 400, me_y);
				
					if (dist > 64) {
						var dir = point_direction(me_x, me_y, 400, me_y);
						var action = (dir == 0) ? actions.right : actions.left;
						actions.left.release();
						actions.right.release();
						action.hold(irandom_range(get_frames(0.1), get_frames(0.2)));
					}
				}
			}
		}
	}

	alarm_frames(11, 1);
});