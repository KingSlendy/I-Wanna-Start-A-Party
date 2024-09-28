event_inherited();

minigame_start = minigame2vs2_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_jump = (y < 304);
		enable_shoot = false;
		coin_can_toss = false;
		coin_toss_id = 0;
		coin_line_stack = [];
		coin_line_stack_angle = 90;
		coin_line_stack_velocity = 0;
		coin_line_stack_separation = 1;
		jump_delay = 0;
		coin_line_stack_delay = 0;
	}
}

minigame_time = 60;
minigame_time_end = function() {
	var player_stacks = [];
	
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_id(i);
		
		if (player.y < 304) {
			continue;
		}
		
		array_push(player_stacks, { network_id: i, stack_amount: array_length(player.coin_line_stack) });
	}
	
	if (player_stacks[0].stack_amount > player_stacks[1].stack_amount) {
		minigame4vs_points(player_stacks[0].network_id);
	} else if (player_stacks[1].stack_amount > player_stacks[0].stack_amount) {
		minigame4vs_points(player_stacks[1].network_id);
	}
	
	minigame_finish();
}

player_type = objPlayerPlatformer;

timer = 0;

coin_calculate_coords = function(x, y, n, angle, separation) {
	var length = sprite_get_height(sprMinigame2vs2_Stacking_CoinStack) * n;
	var coord_x = x - sprite_get_width(sprMinigame2vs2_Stacking_CoinStack) / 2 + lengthdir_x(length * separation, angle);
	var coord_y = y - 20 - length;
	return { coord_x, coord_y };
}

alarm_override(1, function() {
	alarm_inherited(1);
	alarm_instant(4);
});

alarm_create(4, function() {
	next_seed_inline();
	var c;
	
	c = instance_create_layer(-24, irandom_range(48, 176), "Coins", objMinigame2vs2_Stacking_CoinBounce);
	c.hspd = irandom_range(3, 7);
	
	c = instance_create_layer(800, irandom_range(48, 176), "Coins", objMinigame2vs2_Stacking_CoinBounce);
	c.hspd = -irandom_range(3, 7);
	
	alarm_call(4, random_range(2, 3));
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);
		
		with (player) {
			if (y < 304) {
				if (!coin_can_toss) {
					var coin = instance_nearest(x, y, objMinigame2vs2_Stacking_CoinBounce);
					
					if (coin != noone) {
						if (point_distance(x, y, coin.x, y) > 12) {
							var action = (x > coin.x) ? actions.left : actions.right;
							action.press();
						}
						
						if (--jump_delay <= 0 && point_distance(x, y, x, coin.y) > 12) {
							jump_delay = irandom_range(10, 15);
							actions.jump.hold(jump_delay - 4);
						}
					}
				} else {
					if (point_distance(x, y, teammate.x, y) > 6) {
						var action = (x > teammate.x) ? actions.left : actions.right;
						action.press();
					} else {
						actions.shoot.press();
					}
				}
			} else {
				if (array_length(coin_line_stack) < 3) {
					var coin_falling = false;
					
					with (objMinigame2vs2_Stacking_CoinStack) {
						if (network_id == other.teammate.network_id && stacked_id == null) {
							coin_falling = true;
						}
					}
					
					if (!coin_falling) {
						if (point_distance(x, y, teammate.x, y) > 6) {
							var action = (x > teammate.x) ? actions.left : actions.right;
							action.press();
						}
					}
				} else if (--coin_line_stack_delay <= 0) {
					if (point_distance(coin_line_stack_angle, 0, 90, 0) > 5) {
						var diff = sign(angle_difference(coin_line_stack_angle, 90));
						var action = null;
						
						if (diff == 1) {
							action = actions.right;
						}
						
						if (diff == -1) {
							action = actions.left;
						}
						
						if (action != null) {
							var stack_delay = irandom_range(3, 5);
							action.hold(stack_delay);
							coin_line_stack_delay = stack_delay * 4;
						}
					}
				}
			}
		}
	}

	alarm_frames(11, 1);
});

function coin_toss(network_id, coin_id = -1, network = true) {
	var player = focus_player_by_id(network_id);
	var c = null;
	
	with (player) {
		c = instance_create_layer(x - sprite_get_width(sprMinigame2vs2_Stacking_CoinStack) / 2 - 2, y + 16, "Coins", objMinigame2vs2_Stacking_CoinStack);
		c.network_id = player.network_id;
		c.coin_id = (coin_id == -1) ? coin_toss_id++ : coin_id;
		coin_can_toss = false;
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Stacking_CoinToss);
		buffer_write_data(buffer_u8, network_id);
		buffer_write_data(buffer_u16, c.coin_id);
		network_send_tcp_packet();
	}
}

function coin_line_stack_fall(network_id, network = true) {
	var player = focus_player_by_id(network_id);
	
	with (player) {
		for (var i = 0; i < array_length(coin_line_stack); i++) {
			var coin = coin_line_stack[i];
			coin.hspd = -coin_line_stack_velocity * 2;
			coin.grav = 0.2;
			coin.stacked_id = null;
			coin.stacked_falling = true;
		}
		
		coin_line_stack = [];
		coin_line_stack_angle = 90;
		coin_line_stack_velocity = 0;
	}
	
	with (objPlayerBase) {
		if (self.network_id == player.network_id || self.network_id == player.teammate.network_id) {
			continue;
		}
				
		minigame4vs_points(self.network_id);
	}
	
	minigame_finish();
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Stacking_CoinLineStackFall);
		buffer_write_data(buffer_u8, network_id);
		network_send_tcp_packet();
	}
}