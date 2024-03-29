event_inherited();

minigame_start = minigame2vs2_start;
minigame_players = function() {
	with (objPlayerBase) {
		state = -1;
		state_presses = [
			false,
			null,
			[false, 0],
			false,
			[false, false, get_frames(0.5)],
			null,
			false,
			false,
			false,
			null,
			[get_frames(5), 0],
			null,
			false,
			[get_frames(5), 0],
			false,
			[[], null, false],
			[[], null, false],
			[get_frames(0.25), false],
			[false, get_frames(1)]
		];
	
		finished = false;
	}
}

minigame_camera = CameraMode.Split4;
player_type = objPlayerPlatformer;

alarm_override(11, function() {
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
				case 0: //Jump to first switch.
					if (!state_presses[state]) {
						actions.jump.hold(20);
						state_presses[state] = true;
					}
				
					actions.right.press();
					break;
			
				case 1: //Hold right for the door to open.
					actions.right.press();
					break;
				
				case 2: case 5: case 9: case 11: //Start shooting switch.
					if (!state_presses[2][0]) {
						actions.right.hold(5);
						state_presses[2][0] = true;
					}
				
					if (state == 11) {
						actions.right.release(true);
					}
			
					if (--state_presses[2][1] <= 0) {
						actions.shoot.press();
						state_presses[2][1] = irandom_range(5, 8);
					}
					break;
				
				case 3: case 6: //Get out of switch, continue.
					if (!state_presses[state]) {
						actions.left.hold(15);
						state_presses[state] = true;
					}
				
					if (!actions.left.held()) {
						actions.right.press();
					}
					break;
				
				case 4:
					if (!state_presses[state][0]) {
						actions.right.hold(50);
						state_presses[state][0] = true;
					}
				
					if (--state_presses[state][2] <= 0 && !state_presses[state][1]) {
						actions.jump.hold(20);
						state_presses[2][0] = false;
						state_presses[state][1] = true;
					}
					break;
				
				case 7: case 8: case 12: case 14: //Jump out of switch hole.
					if (!state_presses[state]) {
						if (state == 7) {
							actions.right.hold(37);
						} else if (state == 8) {
							actions.right.hold(17);
						} else {
							actions.right.hold(65);
						}
					
						actions.jump.hold(20);
						state_presses[state] = true;
					}
					break;
				
				case 10: case 13: //Jump to platform.
					if (--state_presses[state][0] <= 0) {
						actions.right.hold(25);
					
						if (state_presses[state][1] < 5) {
							actions.jump.hold(10);
							state_presses[state][0] = (state_presses[state][1] != 2) ? 17 : 11;
						}
					
						state_presses[state][1]++;
					}
					break;
				
				case 15: case 16: //We've arrived at the warp batches, choose a warp at random.
					if (state_presses[state][1] == null && !state_presses[state][2]) {
						var iter = (state == 15) ? 5 : 13;
						var start_x = (state == 15) ? 1152 : 1472;
						var choices = [];
					
						for (var i = 0; i < iter; i++) {
							var warp_x = start_x + 32 * i;
						
							if (!array_contains(state_presses[state][0], warp_x)) {
								array_push(choices, warp_x);
							}
						}
					
						if (array_length(choices) > 0) {
							array_shuffle_ext(choices);
							state_presses[state][1] = choices[0] + 16;
						}
					}
				
					if (state_presses[state][1] != null) {
						var dist = point_distance(x, y, state_presses[state][1], y);
				
						if (dist <= 3) {
							actions.jump.hold(10);
						} else if (place_meeting(x, y + 1, objBlock)) {
							var dir = point_direction(x, y, state_presses[state][1], y);
							var action = (dir == 0) ? actions.right : actions.left;
							action.press();
						}
					}
					break;
				
				case 17:
					actions.right.hold(100);
				
					if (!state_presses[state][1] && --state_presses[state][0] <= 0) {
						actions.jump.hold(20);
						state_presses[state][1] = true;
					}
					break;
				
				case 18:
					//print(state_presses[state]);
					
					//if (array_length(state_presses[state]) == 0) {
					//	print(state_presses);
					//	state_presses[state] = [true, 0];
					//}
					
					if (!state_presses[state][0]) {
						actions.right.hold(3);
						state_presses[state][0] = true;
					}
					
					var timer = state_presses[state][1] - 1;
					state_presses[state][1] = timer;
					
					if (timer <= 0) {
						actions.jump.hold(8);
						state_presses[state][1] = irandom_range(37, 45);
					}
					break;
			}
		}
	}

	alarm_frames(11, 1);
});