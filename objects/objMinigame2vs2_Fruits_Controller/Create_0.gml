with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_jump = false;
	enable_shoot = false;
	move_delay_timer = 0;
}

event_inherited();

minigame_start = minigame2vs2_start;
minigame_time = 30;
minigame_time_end = function() {
	alarm_stop(4);
	minigame_finish();
	
	if (trophy_small > 0) {
		gain_trophy(25);
	}
	
	if (trophy_gordos > 0) {
		gain_trophy(26);
	}
}

points_draw = true;
player_check = objPlayerPlatformer;

for (var i = 1; i <= global.player_max; i++) {
	var player = focus_player_by_id(i);
	var b = instance_create_layer(player.x, player.y - 10, "Actors", objMinigame2vs2_Fruits_Basket);
	b.follow = player;
}

fruit_positions = [[], []];
fruit_types = [[], []];
current = 0;

repeat (2000) {
	array_push(fruit_positions[0], irandom_range(32, 320));
	array_push(fruit_positions[1], irandom_range(480, 768));
}

repeat (2000) {
	for (var i = 0; i < 2; i++) {
		array_push(fruit_types[i], choose(-2, 0, 1, 2));
	}
}

trophy_small = 5;
trophy_gordos = 3;

alarm_override(1, function() {
	alarm_inherited(1);
	alarm_frames(4, 1);
});

alarm_create(4, function() {
	for (var i = 0; i < 2; i++) {
		var f = instance_create_layer(fruit_positions[i][current], 256, "Actors", objMinigame2vs2_Fruits_Fruit);
		var type = fruit_types[i][current++];
		f.type = type;

		switch (type) {
			case -2:
				with (f) {
					instance_change(objMinigame2vs2_Fruits_Gordo, false);
					vspeed = 5;
				}
				break;
	
			case 0:
				f.vspeed = 2;
				break;
		
			case 1:
				f.image_xscale = 0.5;
				f.image_yscale = 0.5;
				f.vspeed = 4;
				break;
		
			case 2:
				f.image_xscale = 0.25;
				f.image_yscale = 0.25;
				f.vspeed = 6;
				break;
		}
	}

	alarm_call(4, 0.5);
});

alarm_override(11, function() {
	if (global.player_id != 1) {
		return;
	}

	for (var i = 2; i <= global.player_max; i++) {
		if (!instance_exists(objMinigame2vs2_Fruits_Fruit)) {
			break;
		}
	
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);
		
		with (player) {
			if (move_delay_timer > 0) {
				move_delay_timer--;
				break;
			}
		
			var me_x = x - 1;
			var me_y = y - 7;
			var near = instance_nearest(me_x, me_y, objMinigame2vs2_Fruits_Fruit);
			var check_x = near.x;
		
			if (point_distance(me_x, me_y, check_x, me_y) > 1) {
				var dir = point_direction(me_x, me_y, check_x, me_y);
				var action = (dir == 0) ? actions.right : actions.left;
				action.hold(6);
			}
		
			if (0.05 > random(1)) {
				move_delay_timer = irandom_range(get_frames(0.25), get_frames(0.5));
			}
		}
	}

	alarm_frames(11, 1);
});