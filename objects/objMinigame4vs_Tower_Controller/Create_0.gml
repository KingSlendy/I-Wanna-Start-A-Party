event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		enable_jump = false;
		enable_shoot = false;
	}
}

minigame_camera = CameraMode.Split4;
action_end = function() {
	set_spd(0);
	alarm_stop(4);
	alarm_stop(5);
}

player_type = objPlayerPlatformer;

scene_spd = 0;
prev_openings = array_create(global.player_max, 2);

function set_spd(spd) {
	scene_spd = spd;
	layer_vspeed("Background", scene_spd);
	objMinigame4vs_Tower_Spike.vspeed = scene_spd;
	objMinigame4vs_Tower_Block.vspeed = scene_spd;
	objMinigame4vs_Tower_Crack.vspeed = scene_spd;
	
	if (instance_exists(objMinigame4vs_Tower_Trophy)) {
		objMinigame4vs_Tower_Trophy.vspeed = scene_spd;
	}
}

trophy_floor = true;

alarm_override(1, function() {
	alarm_inherited(1);
	alarm_instant(4);
	alarm_instant(5);
});

alarm_create(function() {
	next_seed_inline();
	var start_y = infinity;

	with (objMinigame4vs_Tower_Block) {
		start_y = min(start_y, y);
	}

	start_y -= 32;

	for (var i = 0; i < global.player_max; i++) {
		var can_crack = (irandom(4) == 0);
		var created_crack = false;
		var start_x = 32 + (32 * 6) * i;

		for (var j = 0; j < 4; j++) {
			instance_create_layer(start_x - 32, start_y - 32 * j, "Collisions", objMinigame4vs_Tower_Block2);
			
			if (i == 3) {
				instance_create_layer(start_x + 32 * 5, start_y - 32 * j, "Collisions", objMinigame4vs_Tower_Block2);
			}
		}
		
		var opening = -1;
		
		if (prev_openings[i] == -1) {
			var opening = irandom(4);
		} else {
			var opening = clamp(prev_openings[i] + choose(-1, 1), 0, 4);
		}
		
		for (var j = 0; j < 5; j++) {
			if (j == opening) {
				continue;
			}
			
			instance_create_layer(start_x + 32 * j, start_y, "Collisions", objMinigame4vs_Tower_Block);
			instance_create_layer(start_x + 32 * j, start_y + 32, "Actors", objMinigame4vs_Tower_Spike);
		
			if (j < 4 && !can_crack && !created_crack && irandom(4) == 0) {
				instance_create_layer(start_x + 32 * (j - 1), start_y - 32 * 4, "Cracks", objMinigame4vs_Tower_Crack);
				created_crack = true;
			}
		}
		
		prev_openings[i] = opening;
	}

	set_spd(scene_spd);
	alarm_frames(4, 50 - clamp(scene_spd * 4.15, 0, 38));
});

alarm_create(5, function() {
	if (scene_spd < 10) {
		set_spd(scene_spd + 1);
	}

	alarm_call(5, 3);
});

alarm_override(11, function() {
	instance_deactivate_object(objMinigame4vs_Tower_Crack);
	instance_deactivate_object(objMinigame4vs_Tower_Trophy);

	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);
		
		with (player) {
			var check_x = x;
			var check_y = y;
			var me_x = check_x;
			var me_y = check_y;
		
			if (!collision_line(me_x, me_y, me_x, me_y - 32 * 4, all, false, true)) {
				continue;
			}
		
			var decided = false;
		
			for (var j = 0; j < 2; j++) {
				var k = 0;
		
				while (true) {
					if (place_meeting(me_x + 32 * k, me_y, objBlock)) {
						break;
					}
			
					if (!place_meeting(me_x + 32 * k, me_y - 32 * 3, all)) {
						check_x = me_x + 32 * k;
						decided = true;
						break;
					}
			
					k += (j == 0) ? -1 : 1;
				}
			}
		
			if (decided && point_distance(me_x, me_y, check_x, check_y) > 1) {
				var dir = point_direction(me_x, me_y, check_x, check_y);
				var action = (dir == 0) ? actions.right : actions.left;
				action.hold(6);
			}
		}
	}

	instance_activate_object(objMinigame4vs_Tower_Crack);
	instance_activate_object(objMinigame4vs_Tower_Trophy);
	alarm_frames(11, 1);
});