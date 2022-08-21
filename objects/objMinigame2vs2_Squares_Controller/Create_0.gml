with (objPlayerBase) {
	change_to_object(objPlayerStatic);
}

event_inherited();

minigame_start = minigame2vs2_start;
minigame_time = 40;
action_end = function() {
	alarm_stop(4);
	alarm_stop(5);
	
	var player = focus_player_by_id(global.player_id);
	
	if (minigame2vs2_get_points(player.network_id, player.teammate.network_id) >= 22) {
		gain_trophy(29);
	}
}

points_draw = true;
player_check = objPlayerStatic;

alarm_override(0, function() {
	alarm_inherited(0);
	alarm_call(4, 0.5);
	alarm_call(5, 0.5);
});

alarm_create(4, function() {
	next_seed_inline();
	var index = irandom(sprite_get_number(sprMinigame2vs2_Squares_Half1) - 1);
	var h1 = instance_create_layer(168, -100, "Actors", objMinigame2vs2_Squares_Halfs);
	h1.image_index = index;
	h1.image_angle = choose(irandom_range(0, 45), irandom_range(135, 359));
	h1.network_id = points_teams[0][0].network_id;
	h1.color = info.player_colors[0];
	h1.target_y = 160;
	var h2 = instance_create_layer(168, 708, "Actors", objMinigame2vs2_Squares_Halfs);
	h2.sprite_index = sprMinigame2vs2_Squares_Half2;
	h2.image_index = index;
	h2.image_angle = choose(irandom_range(0, 45), irandom_range(135, 359));
	h2.network_id = points_teams[0][1].network_id;
	h2.color = info.player_colors[0];
	h2.target_y = 448;
});

alarm_create(5, function() {
	next_seed_inline();
	var index = irandom(sprite_get_number(sprMinigame2vs2_Squares_Half1) - 1);
	var h1 = instance_create_layer(568, -100, "Actors", objMinigame2vs2_Squares_Halfs);
	h1.image_index = index;
	h1.image_angle = choose(irandom_range(0, 45), irandom_range(135, 359));
	h1.network_id = points_teams[1][0].network_id;
	h1.color = info.player_colors[1];
	h1.target_y = 160;
	var h2 = instance_create_layer(568, 708, "Actors", objMinigame2vs2_Squares_Halfs);
	h2.sprite_index = sprMinigame2vs2_Squares_Half2;
	h2.image_index = index;
	h2.image_angle = choose(irandom_range(0, 45), irandom_range(135, 359));
	h2.network_id = points_teams[1][1].network_id;
	h2.color = info.player_colors[1];
	h2.target_y = 448;
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		with (objMinigame2vs2_Squares_Halfs) {
			if (network_id != i) {
				continue;
			}
		
			var angle_diff = angle_difference(image_angle, 90);
		
			if (abs(angle_diff) <= 6) {
				continue;
			}

			var action = (sign(angle_diff) == 1) ? actions.right : actions.left;
			action.hold(irandom_range(1, 10));
		}
	}

	alarm_frames(11, 8);
});