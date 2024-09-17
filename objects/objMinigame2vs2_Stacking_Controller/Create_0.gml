event_inherited();

minigame_start = minigame2vs2_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_shoot = false;
		coin_following = false;
		space = player_info_by_id(network_id).space;
		coin_x_left = 195;
		coin_x_right = 610;
	}
}

player_type = objPlayerPlatformer;

coin_check_collision = function(o) { return (o.following_id == null && o.hspd == 0 && o.vspd == 0); }

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);
		
		with (player) {
			if (!coin_following) {
				var near = instance_nearest_any(x, y, objMinigame2vs2_Stacking_Coin, function(o) { return ((space == c_blue && o.x < coin_x_left) || (space == c_red && o.x > coin_x_right)); });
			
				if (place_meeting(x, y, near)) {
					actions.shoot.press();
				}
			} else {
				var min_coin_x = infinity;
				var max_coin_x = -infinity;
				var min_coin_y = infinity;
				
				with (objMinigame2vs2_Stacking_Coin) {
					if ((space == c_blue && x < coin_x_left) || (space == c_red && x > coin_x_right)) {
						continue;
					}
					
					min_coin_x = min(bbox_left, min_coin_x);
					max_coin_x = max(bbox_right, max_coin_x);
					min_coin_y = min(bbox_top, min_coin_y);
				}
				
				actions.shoot.press();
				
				if (point_distance(x, 0, min_coin_x + (max_coin_x - min_coin_x) / 2, 0) <= 10 && place_meeting(x, y, objMinigame2vs2_Stacking_Coin)) {
					actions.jump.hold(irandom_range(12, 18));
				}
			}
		}
	}

	alarm_frames(11, 1);
});