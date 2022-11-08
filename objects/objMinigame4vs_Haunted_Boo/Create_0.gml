ang = 0;
lookout = false;
player_targets = [];
target_x = x;
target_y = y;
target_player = null;
targeting = false;
returning = false;

function start_target_player() {
	if (alarm_is_stopped(3)) {
		alarm_stop(0);
		alarm_stop(1);
		alarm_stop(2);
		alarm_call(3, 1);
		targeting = true;
	}
}

function next_target_player() {
	if (objMinigameController.info.is_finished) {
		return;
	}
	
	if (array_length(player_targets) == 0) {
		target_player = null;
		target_x = xstart;
		target_y = ystart;
		returning = true;
		return;
	}
	
	var min_dist = infinity;
	
	for (var i = 0; i < array_length(player_targets); i++) {
		var player = focus_player_by_id(player_targets[i]);
		min_dist = min(min_dist, point_distance(x, y, player.x, player.y));
	}
	
	for (var i = 0; i < array_length(player_targets); i++) {
		var player = focus_player_by_id(player_targets[i]);
		
		if (point_distance(x, y, player.x, player.y) == min_dist) {
			target_player = player;
			target_x = player.x;
			target_y = player.y;
			array_delete(player_targets, i, 1);
			break;
		}
	}
}

alarms_init(4);

alarm_create(function() {
	lookout = true;
	music_pause();
	audio_play_sound(sndMinigame4vs_Haunted_Boo, 0, false);
	
	if (trial_is_title(HAUNTED_REFLEXES)) {
		alarm_call(1, 0.35);
		return;
	}
	
	next_seed_inline();
	alarm_call(1, random_range(0.5, 1));
});

alarm_create(function() {
	image_index = 0;
	image_xscale *= -1;
	alarm_call(2, 2);
});

alarm_create(function() {
	image_index = 1;
	image_xscale *= -1;
	lookout = false;

	if (objMinigameController.info.is_finished) {
		return;
	}

	music_resume();

	if (objMinigameController.state > 1) {
		next_seed_inline();
		alarm_call(0, random_range(2, 4));
	} else {
		with (objMinigameController) {
			alarm_call(0, 1);
		}
	}
});

alarm_create(function() {
	lookout = false;
	objPlayerBase.frozen = true;
	next_target_player();
});