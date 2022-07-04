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
		
		switch (state) {
			case 0:
				if (!state_presses[state]) {
					actions.jump.hold(20);
					state_presses[state] = true;
				}
				
				actions.right.press();
				break;
			
			case 1:
				actions.right.press();
				break;
				
			case 2: case 5: case 9: case 11:
				if (!state_presses[2][0]) {
					actions.right.hold(get_frames(0.1));
					state_presses[2][0] = true;
				}
				
				if (state == 11) {
					actions.right.release(true);
				}
			
				if (--state_presses[2][1] <= 0) {
					actions.shoot.press();
					state_presses[2][1] = get_frames(random_range(0.1, 0.15));
				}
				break;
				
			case 3: case 6:
				if (!state_presses[state]) {
					actions.left.hold(get_frames(0.3));
					state_presses[state] = true;
				}
				
				if (!actions.left.held()) {
					actions.right.press();
				}
				break;
				
			case 4:
				if (!state_presses[state][0]) {
					actions.right.hold(get_frames(1))
					state_presses[state][0] = true;
				}
				
				if (--state_presses[state][2] <= 0 && !state_presses[state][1]) {
					actions.jump.hold(20);
					state_presses[2][0] = false;
					state_presses[state][1] = true;
				}
				break;
				
			case 7: case 8: case 12: case 14:
				if (!state_presses[state]) {
					if (state == 7) {
						actions.right.hold(get_frames(0.75));
					} else if (state == 8) {
						actions.right.hold(get_frames(0.35));
					} else {
						actions.right.hold(get_frames(1.3));
					}
					
					actions.jump.hold(20);
					state_presses[state] = true;
				}
				break;
				
			case 10: case 13:
				if (--state_presses[state][0] <= 0) {
					actions.right.hold(get_frames(0.5));
					
					if (state_presses[state][1] < 5) {
						actions.jump.hold(10);
						state_presses[state][0] = get_frames((state_presses[state][1] != 2) ? 0.35 : 0.12);
					}
					
					state_presses[state][1]++;
				}
				break;
		}
	}
	
	//var keys = variable_struct_get_names(actions);
	//var action = actions[$ keys[irandom(array_length(keys) - 1)]];
		
	//switch (irandom(2)) {
	//	case 0:
	//		action.hold(irandom(21));
	//		break;
				
	//	case 1:
	//		action.press();
	//		break;
				
	//	case 2:
	//		action.release(true);
	//		break;
	//}
}

alarm[11] = 1;