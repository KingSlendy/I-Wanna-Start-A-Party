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
		if (y < 128) {
			var available = true;
			
			with (objMinigame1vs3_Avoid_Block) {
				if (image_index == image_number - 1) {
					other.chosed_block = -1;
					available = false;
					break;
				}
			}
			
			if (!available) {
				continue;
			}
			
			if (chosed_block == -1) {
				chosed_block = choose(288, 320, 352, 416, 448, 480) + 16;
			}
			
			var me_x = x - 1;
			var me_y = y - 7;
			
			if (point_distance(me_x, me_y, chosed_block, me_y) > 6) {
				var dir = floor(point_direction(me_x, me_y, chosed_block, me_y));
				var action = (dir == 0) ? actions.right : actions.left;
				action.hold(6);
			} else {
				actions.jump.hold(15);
			}
		} else {
			var keys = variable_struct_get_names(actions);
			var action = actions[$ keys[irandom(array_length(keys) - 1)]];
		
			switch (irandom(2)) {
				case 0:
					action.hold(irandom(21));
					break;
				
				case 1:
					action.press();
					break;
				
				case 2:
					action.release(true);
					break;
			}
		}
	}
}

alarm[11] = 1;
