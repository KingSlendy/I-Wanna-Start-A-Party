event_inherited();

minigame_players = function() {
	objPlayerBase.sledge = null;
}

minigame_camera = CameraMode.Split4;
action_end = function() {
	for (var i = 0; i < global.player_max; i++) {
		alarm_stop(4 + i);
		set_spd(0, i + 1);
	}
}

player_type = objPlayerStatic;

space_count = array_create(global.player_max, 0);
space_objs = [];
back_spd = array_create(global.player_max, 0);

surf = noone;

//layer_script_begin("Background", function() {
//	with (objMinigameController) {
//		if (!surface_exists(surf)) {
//			surf = surface_create(800, 608);
//		}
	
//		surface_set_target(surf);
//	}
//});

//layer_script_end("Trees", function() {
//	surface_reset_target();	
//});

next_seed_inline();

for (var i = 0; i < global.player_max; i++) {
	array_push(space_objs, []);
	
	repeat (100) {
		var num = irandom(3);
		array_push(space_objs[i], num);
	}
}

sledge_start = false;

function jingle_obstacles(player_turn) {
	var start_x = -infinity;
	var start_y = 120 + 152 * (player_turn - 1);

	with (objMinigame4vs_Jingle_Block) {
		if (self.player_turn != player_turn) {
			continue;
		}
		
		start_x = max(start_x, x);
	}

	start_x += 32;
		
	with (instance_create_layer(start_x, start_y, "Collisions", objMinigame4vs_Jingle_Block)) {
		self.player_turn = player_turn;
	}
		
	if (space_count[player_turn - 1] % 10 == 0) {
		var objs = [objMinigame4vs_Jingle_Spike, objMinigame4vs_Jingle_Tree, objMinigame4vs_Jingle_Candy, objMinigame4vs_Jingle_Toggle];
		var count = floor(space_count[player_turn - 1] / 10);
		var obj = null;
		
		if (count < 35) {
			obj = objs[space_objs[player_turn - 1][count]];
		} else if (count == 35) {
			obj = objMinigame4vs_Jingle_Goal;
		}
			
		if (obj != null) {
			with (instance_create_layer(start_x, start_y - sprite_get_height(object_get_sprite(obj)), "Actors", obj)) {
				self.player_turn = player_turn;
			}
		}
	}
	
	space_count[player_turn - 1]++;
	set_spd(-9, player_turn);
	alarm_call(4 + (player_turn - 1), 0.04);
}

function set_spd(scene_spd, player_turn) {
	if (scene_spd != 0) {
		var bg_layers = ["Background", "Trees"];
	
		for (var i = 0; i < array_length(bg_layers); i++) {
			var bg_layer = bg_layers[i];
			var spd = scene_spd * (0.3 * (i + 1));
			layer_hspeed(bg_layer, spd);
		}
	}
	
	with (objMinigame4vs_Jingle_Block) {
		if (self.player_turn != player_turn) {
			continue;
		}
		
		hspeed = scene_spd;
	}
}

alarm_override(1, function() {
	with (objMinigame4vs_Jingle_Sledge) {
		focus_player_by_turn(player_turn).sledge = id;
	}
	
	for (var i = 0; i < global.player_max; i++) {
		alarm_instant(4 + i);
	}
	
	sledge_start = true;
});

alarm_create(4, function() {
	jingle_obstacles(1);
});

alarm_create(5, function() {
	jingle_obstacles(2);
});

alarm_create(6, function() {
	jingle_obstacles(3);
});

alarm_create(7, function() {
	jingle_obstacles(4);
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			var obstacle = instance_place(x + 160, y, objMinigame4vs_Jingle_Spike);
			
			if (obstacle != noone) {
				if (obstacle.object_index == objMinigame4vs_Jingle_Spike) {
					if (0.5 > random(1)) {
						break;
					}
					
					actions.jump.press();
				} else if (obstacle.object_index == objMinigame4vs_Jingle_Tree || obstacle.object_index == objMinigame4vs_Jingle_Candy) {
					if (0.05 > random(1)) {
						break;
					}
					
					actions.shoot.press();
				} else if (obstacle.object_index == objMinigame4vs_Jingle_Toggle && obstacle.sprite_index == sprMinigame4vs_Jingle_ToggleFull) {
					if (0.75 > random(1)) {
						break;
					}
					
					actions.jump.press();
				}
			}
		}
	}

	alarm_frames(11, 1);
});