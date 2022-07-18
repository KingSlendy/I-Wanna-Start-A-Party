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
		
		if (enable_shoot) {
			var me_x = x - 1;
			var me_y = y - 7;
			
			if (y > 416) {
				var dist = point_distance(me_x, me_y, 400, me_y);
			
				if (dist <= 3) {
					if (vspd >= 0) {
						actions.jump.hold(15);
					}
				} else {
					var dir = point_direction(me_x, me_y, 400, me_y);
					var action = (dir == 0) ? actions.right : actions.left;
					action.press();
				}
			} else {
				if (!actions.left.held()) {
					if (x > 384) {
						actions.left.hold(15);
					} else if (!instance_exists(objBullet)) {
						actions.right.press();
						actions.shoot.press();
					}
				}
			}
		} else {
			if (!actions.right.held() && y < 416) {
				actions.right.hold(irandom_range(10, 20));
			}
		}
	}
}

alarm[11] = 1;