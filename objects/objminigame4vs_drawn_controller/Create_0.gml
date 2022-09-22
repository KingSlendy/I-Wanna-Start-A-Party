event_inherited();

minigame_players = function() {
	objPlayerBase.enable_shoot = false;
}

minigame_time = 30;
points_draw = true;
player_type = objPlayerPlatformer;
trophy_green = true;
trophy_double = true;

alarm_override(2, function() {
	alarm_inherited(2);
	
	if (array_contains(info.players_won, global.player_id)) {
		if (trophy_green) {
			achieve_trophy(58);
		}
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
			if (frozen) {
				break;
			}
			
			var me_x = x - 1;
			var me_y = y - 7;
			
			if (on_block) {
				var near = null;
				var record = infinity;
			
				with (objMinigame4vs_Drawn_Block) {
					if (image_blend == c_white) {
						continue;
					}
					
					if (0.01 > random(1)) {
						break;
					}
				
					var dist = point_distance(me_x, me_y, x + 16, me_y);
				
					if (dist < record) {
						near = id;
						record = dist;
					}
				}
			
				if (near == null) {
					break;
				}
				
				if (place_meeting(x, y + 1, near)) {
					actions.jump.hold(35);
					break;
				}
				
				var action = (point_direction(me_x, me_y, near.x + 16, me_y) == 0) ? actions.right : actions.left;
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
				
					var dist = point_distance(me_x, me_y, x + 16, y + 16);
				
					if (dist < record) {
						near = id;
						record = dist;
					}
				}
				
				if (near == null || point_distance(me_x, me_y, near.x + 16, me_y) < 3) {
					break;	
				}
				
				var dir = point_direction(me_x, me_y, near.x + 16, near.y + 16);
				var action = ((dir >= 0 && dir <= 90) || (dir >= 270 && dir <= 359)) ? actions.right : actions.left;
				action.press();
			}
		}
	}

	alarm_frames(11, 1);
});