event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		enable_shoot = false;
		chosen_block = null;
	}
}

minigame_time = 30;
points_draw = true;
player_type = objPlayerPlatformer;
trophy_green = true;
trophy_double = true;

if (trial_is_title(RANDRANDRAND_TIME)) {
	instance_destroy(objMinigame4vs_Drawn_Key);
	
	repeat (irandom_range(20, 50)) {
		do {
			var rand_x = irandom_range(0, 800 - 32);
			var rand_y = irandom_range(160, 608 - 96);
		} until (!position_meeting(rand_x, rand_y, objPlayerReference));
		
		instance_create_layer(rand_x, rand_y, "Collisions", objMinigame4vs_Drawn_Key, {
			image_blend: choose(c_lime, c_yellow, c_red)
		});
	}
}

alarm_override(2, function() {
	alarm_inherited(2);
	
	if (array_contains(info.players_won, global.player_id) && trophy_green) {
		achieve_trophy(58);
	}
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			if (on_block) {
				if (chosen_block == null) {
					var record = infinity;
			
					with (objMinigame4vs_Drawn_Block) {
						if (image_blend == c_white || 0.1 > random(1)) {
							continue;
						}
				
						var dist = point_distance(other.x, other.y, x + 16, y);
				
						if (dist < record) {
							other.chosen_block = id;
							record = dist;
						}
					}
				}
			
				if (chosen_block == null) {
					break;
				}
				
				if (place_meeting(x, y + 1, chosen_block)) {
					actions.jump.hold(35);
					chosen_block = null;
					break;
				}
				
				var action = (point_direction(x, y, chosen_block.x + 16, y) == 0) ? actions.right : actions.left;
				action.press();
			} else {
				if (vspd >= 0 && jump_left > 0) {
					actions.jump.hold(30);
				}
				
				var near = null;
				var record = infinity;
			
				with (objMinigame4vs_Drawn_Key) {
					if (!visible) {
						continue;
					}
				
					var dist = point_distance(other.x, other.y, x + 16, y + 16);
				
					if (dist < record) {
						near = id;
						record = dist;
					}
				}
				
				if (near == null || point_distance(x, y, near.x + 16, y) < 3) {
					break;	
				}
				
				var dir = point_direction(x, y, near.x + 16, near.y + 16);
				var action = ((dir >= 0 && dir <= 90) || (dir >= 270 && dir <= 359)) ? actions.right : actions.left;
				action.press();
			}
		}
	}

	alarm_frames(11, 1);
});