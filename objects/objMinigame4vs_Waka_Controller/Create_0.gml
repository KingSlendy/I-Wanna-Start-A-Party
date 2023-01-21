event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		guess_path = -1;
	}
}

minigame_time = (!trial_is_title(WAKA_DODGES)) ? -1 : 40;
minigame_time_end = function() {
	if (!trial_is_title(WAKA_DODGES)) {
		objPlayerBase.frozen = true;
		alarm_instant(4);
		minigame_time = -1;
	} else {
		minigame_lost_points();
		minigame_finish();
	}
}

action_end = function() {
	alarm_stop(6);
	instance_destroy(objMinigame4vs_Waka_PacMan);	
	audio_stop_sound(sndMinigame4vs_Waka_PacMan);
}

player_type = objPlayerStatic;


next_path = -1;
state_path = -1;
camera_state = -1;
current_round = 0;
player_pos = array_create(global.player_max, 0);

trophy_luigi = true;

function intersect_generate() {
	instance_destroy(objMinigame4vs_Waka_Intersect);
	var map_id = layer_tilemap_get_id("Lines");
			
	for (var c = 0; c < 13; c++) {
		for (var r = 0; r < 55; r++) {
			var tile_x = 192 + c * 32;
			var tile_y = 32 + r * 32;
			var cell_x = tilemap_get_cell_x_at_pixel(map_id, tile_x, tile_y);
			var cell_y = tilemap_get_cell_y_at_pixel(map_id, tile_x, tile_y);
			var tile = 7;
						
			if (c % 4 == 0) {
				tile = 28;
			}
						
			tilemap_set(map_id, tile, cell_x, cell_y);
		}
	}
			
	next_seed_inline();
			
	for (var i = 0; i < 25; i++) {
		instance_create_layer(choose(224, 352, 480), 128 + 64 * i, "Actors", objMinigame4vs_Waka_Intersect);
	}
}

function pacman_generate() {
	next_seed_inline();
	var choices = [208, 336, 464, 592];
				
	repeat ((!trial_is_title(WAKA_DODGES)) ? current_round++ + 1 : 3) {
		array_shuffle(choices);
		instance_create_layer(array_pop(choices), (!trial_is_title(WAKA_DODGES)) ? 48 : 1104, "Actors", objMinigame4vs_Waka_PacMan);
	}
}

alarm_override(1, function() {
	alarm_call(4, 1);
	
	if (trial_is_title(WAKA_DODGES)) {
		alarm_stop(4);
		objPlayerBase.frozen = false;
		alarm_instant(6);
	}
});

alarm_override(2, function() {
	alarm_inherited(2);
	
	if (minigame_has_won() && trophy_luigi && !trial_is_title(WAKA_DODGES)) {
		achieve_trophy(69);
	}
});

alarm_create(4, function() {
	state_path = (state_path + 2 + 1) % 2;
	
	if (state_path == 0 && (current_round == 3 || minigame_lost_all())) {
		minigame_lost_points();
		minigame_finish();
		return;
	}
	
	next_path = 0;
});

alarm_create(5, function() {
	camera_state = 0;
})

alarm_create(6, function() {
	intersect_generate();
	pacman_generate();
	
	with (objMinigame4vs_Waka_PacMan) {
		start_path();
	}
});

alarm_create(11, function() {
	if (trial_is_title(WAKA_DODGES)) {
		return;
	}
	
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player =  focus_player_by_id(i);
	
		if (player_pos[i - 1] == player.guess_path) {
			continue;
		}
	
		if (player_pos[i - 1] < player.guess_path) {
			actions.right.press();
		} else {
			actions.left.press();
		}
	}

	alarm_frames(11, 1);
});