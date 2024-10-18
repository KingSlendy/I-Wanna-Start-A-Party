event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_shoot = false;
		follow_coin = null;
	}
}

minigame_time = 30;
minigame_time_end = function() {
	if (trophy_coin) {
		achieve_trophy(15);
	}
	
	minigame1vs3_points();
	minigame_finish();
}

action_end = function() {
	alarm_stop(4);
}

points_draw = true;
player_type = objPlayerPlatformer;

coin_max_win = 30;
coin_count = 0;
trophy_coin = true;

alarm_override(1, function() {
	alarm_inherited(1);
	alarm_frames(4, 1);
});

alarm_create(4, function() {
	next_seed_inline();
	var c;

	c = instance_create_layer(304, 48, "Collectables", objMinigame1vs3_Coins_Coin);
	c.hspeed = random_range(-2, 2);
	c.coin_id = coin_count++;
	
	c = instance_create_layer(464, 48, "Collectables", objMinigame1vs3_Coins_Coin);
	c.hspeed = random_range(-2, 2);
	c.coin_id = coin_count++;

	alarm_call(4, 0.27);
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			if (follow_coin == null || !instance_exists(follow_coin)) {
				if (minigame1vs3_is_solo(network_id)) {
					with (objMinigame1vs3_Coins_Coin) {
						if (bbox_bottom <= 320) {
							instance_deactivate_object(id);
						}
					}
				} else {
					with (objMinigame1vs3_Coins_Coin) {
						if (bbox_bottom >= 320) {
							instance_deactivate_object(id);
						}
					}
				}
			
				while (true) {
					if (!instance_exists(objMinigame1vs3_Coins_Coin)) {
						follow_coin = null;
						break;
					}
					
					var coin = instance_nearest(x, y, objMinigame1vs3_Coins_Coin);
					var me_dist = distance_to_object(coin);
					var others_dist = infinity;
					
					for (var j = 0; j < minigame1vs3_team_length(); j++) {
						with (minigame1vs3_team(j)) {
							if (id == other.id) {
								continue;
							}
							
							others_dist = min(others_dist, distance_to_object(coin));
						}
					}
					
					if (me_dist <= others_dist) {
						follow_coin = coin;
						break;
					}
					
					instance_deactivate_object(coin);
				}
			
				instance_activate_object(objMinigame1vs3_Coins_Coin);
			}
			
			if (follow_coin == null) {
				break;
			}
			
			var dist = point_distance(x, y, follow_coin.x + 16, follow_coin.y + 16);
			
			if (dist <= 3) {
				break;
			}
			
			var dir = point_direction(x, y, follow_coin.x + 16, follow_coin.y + 16);
			
			if (abs(angle_difference(dir, 270)) >= 16) {
				var dist_to_up = abs(angle_difference(dir, 90));
				
				if (dist_to_up > 4) {
					var action = (dir >= 90 && dir <= 270) ? actions.left : actions.right;
					action.hold(irandom_range(5, 8));
				}
		
				if (vspd >= 0 && dist_to_up < 30) {
					actions.jump.hold(irandom_range(3, 10));
				}
			}
		}
	}

	alarm_frames(11, 1);
});