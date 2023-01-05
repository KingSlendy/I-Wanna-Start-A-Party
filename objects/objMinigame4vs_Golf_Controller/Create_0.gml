event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		if (!is_player_local(network_id)) {
			continue;
		}
		
		var hole_x = objMinigame4vs_Golf_Hole.x + 16 - x;
		var hole_y = objMinigame4vs_Golf_Hole.y - (y + 10);
		
		do {
			var velocity_x = random_range(max_velocity * 0.25, max_velocity * 0.5);
			var velocity_y = velocity_x * hole_y / hole_x - 0.5 * 510 * hole_x / velocity_x;
		} until (abs(velocity_y) <= max_velocity && velocity_y + 510 * (hole_x / velocity_x) > 10);
		
		guess_angle = (point_direction(0, 0, velocity_x, velocity_y) + 360 + random_range(-5, 5)) % 360;
		guess_power = clamp(point_distance(0, 0, velocity_x, velocity_y) / max_velocity + random_range(-0.1, 0.1), 0, 1);
	}
}

minigame_time_end = function() {
	with (focus_player_by_turn(player_turn)) {
		if (is_player_local(network_id)) {
			hit_ball();
		}
	}
	
	minigame_time = -1;
}

points_draw = true;
player_type = objPlayerGolf;

player_turn = 1;
next_turn = -1;

trophy_main = true;

if (trial_is_title(PERFECT_AIM)) {
	with (objMinigame4vs_Golf_Block) {
		if (x >= 224) {
			instance_destroy();
		}
	}
	
	layer_set_visible("Tiles", false);
}

function unfreeze_player() {
	var player = focus_player_by_turn(player_turn);
	player.frozen = false;
	minigame_time = 20;
	alarm_call(10, 1);
	
	if (trial_is_title(PERFECT_AIM)) {
		minigame_time = -1;
		alarm_stop(10);
	}
}

function give_points(player_id, points, network = true) {
	minigame4vs_points(player_id, points);
	
	if (focus_player_by_turn(player_turn).network_id == global.player_id && points == 99) {
		achieve_trophy(62);
	}
	
	if (player_turn == global.player_max) {
		minigame_finish();
	} else {
		next_turn = 0;
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Golf_GivePoints);
		buffer_write_data(buffer_u8, player_id);
		buffer_write_data(buffer_u16, points);
		network_send_tcp_packet();
	}
}

alarm_override(1, function() {
	unfreeze_player();
});

alarm_override(2, function() {
	alarm_inherited(2);
	
	if (array_contains(info.players_won, global.player_id)) {
		if (trophy_main) {
			achieve_trophy(66);
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
			if (!powering) {
				var diff = angle_difference(aim_angle, guess_angle);
				
				if (abs(diff) <= 2) {
					if (0.75 > random(1)) {
						actions.jump.press();
					}
				} else {
					var action = (sign(diff) == -1) ? actions.left : actions.right;
					action.press();
				}
			} else {
				if (point_distance(aim_power, 0, guess_power, 0) <= 0.02 && 0.75 > random(1)) {
					actions.jump.press();
				}
			}
		}
	}

	alarm_frames(11, 1);
});