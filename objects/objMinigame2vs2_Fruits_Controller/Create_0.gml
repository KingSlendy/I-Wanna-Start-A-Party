event_inherited();

minigame_start = minigame2vs2_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_jump = false;
		enable_shoot = false;
		basket = null;
		move_delay_timer = 0;
	}	
}

minigame_time = 30;
minigame_time_end = function() {
	alarm_stop(4);
	minigame_finish();
	
	if (trophy_small > 0) {
		achieve_trophy(25);
	}
	
	if (trophy_gordos > 0) {
		achieve_trophy(26);
	}
}

points_draw = true;
player_type = objPlayerPlatformer;

fruit_positions = [[], []];
fruit_types = [[], []];
current = 0;
next_seed_inline();

repeat (2000) {
	var position = irandom_range(32, 320);
	array_push(fruit_positions[0], position);
	array_push(fruit_positions[1], position + 448);
}

repeat (2000) {
	var type = choose(-2, 0, 1, 2);
	
	for (var i = 0; i < 2; i++) {
		array_push(fruit_types[i], type);
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
		var type = fruit_types[i][current];
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
	
	current++;

	alarm_call(4, 0.5);
});

alarm_override(11, function() {
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
			var gordo = collision_rectangle(basket.bbox_left, basket.bbox_top - 80, basket.bbox_right, basket.bbox_bottom, objMinigame2vs2_Fruits_Gordo, true, true);
			
			if (gordo != noone) {
				if ((gordo.x + 16 > x && !place_meeting(x - 16, y, objBlock)) || place_meeting(x + 16, y, objBlock)) {
					actions.left.press();
				} else {
					actions.right.press();
				}
				
				break;
			}
			
			gordo = instance_nearest(x, y, objMinigame2vs2_Fruits_Gordo);
			
			if (gordo != noone && gordo.bbox_top <= basket.bbox_bottom + 8) {
				break;
			}
			
			if (player_info_by_id(i).turn < player_info_by_id(teammate.network_id).turn) {
				var xx = teammate.xstart;
			} else {
				var xx = teammate.xstart - 96;
			}
			
			with (objMinigame2vs2_Fruits_Fruit) {
				if ((x >= xx && x <= xx + 128 && y >= 0 && y <= 608) || (other.x > 400 && x < 400) || (other.x < 400 && x > 400)) {
					instance_deactivate_object(id);
				}
			}
			
			instance_deactivate_object(objMinigame2vs2_Fruits_Gordo);
			var near = instance_nearest(x, y, objMinigame2vs2_Fruits_Fruit);
			instance_activate_object(objMinigame2vs2_Fruits_Fruit);
			
			if (near == noone) {
				break;
			}
			
			var check_x = near.x;
			var dist = point_distance(x, y, check_x, y);
		
			if (dist <= 4) {
				break;
			}
			
			var dir = point_direction(x, y, check_x, y);
			var action = (dir == 0) ? actions.right : actions.left;
			action.press();
		}
	}

	alarm_frames(11, 1);
});