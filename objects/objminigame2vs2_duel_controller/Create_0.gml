event_inherited();

minigame_start = minigame2vs2_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_move = false;
		enable_jump = false;
	}
}

minigame_time_end = function() {
	with (objPlayerBase) {
		if (is_player_local(network_id)) {
			player_shoot();
		}
	}
}

action_end = function() {
	if (trophy_obtain && trophy_shoot) {
		achieve_trophy(48);
	}
}

points_draw = true;
player_type = objPlayerPlatformer;

player_can_shoot = array_create(global.player_max, false);
player_shot_time = array_create(global.player_max, 0);
cpu_shot_delay = array_create(global.player_max, 0);
take_time = false;
show_mark = false;
fake_mark = false;
revive = -1;
point_condition = 5;

trophy_obtain = true;
trophy_shoot = false;

alarm_override(0, function() {
	alarm_inherited(0);
	alarm_call(1, 2.5);
});

alarm_override(1, function() {
	alarm_inherited(1);
	show_popup(language_get_text("MINIGAMES_DUEL_READY"),,,,,, 0.5);
	audio_play_sound(sndMinigameReady, 0, false);
	player_can_shoot = array_create(global.player_max, true);
	next_seed_inline();
	fake_mark = (!chance(0.4)) ? false : true;
	var time = irandom_range(3, 6);
	
	if (!fake_mark) {
		cpu_shot_delay = [0];

		repeat (global.player_max - 1) {
			array_push(cpu_shot_delay, ceil(get_frames(random_range(time - 0.05, time + 0.6))));
		}
	}

	alarm_call(4, time);
});

alarm_create(4, function() {
	show_mark = true;
	music_pause();
	
	if (!fake_mark) {
		player_shot_time = array_create(global.player_max, 0);
		alarm_call(5, 3);
		alarm_call(7, 3);
		minigame_time = 10;
		alarm_call(10, 1);
		take_time = true;
		audio_play_sound(sndMinigame2vs2_Duel_Mark, 0, false);
	} else {
		alarm_call(8, 3);
		alarm_call(7, 1);
		audio_play_sound(sndMinigame2vs2_Duel_Fake, 0, false);
	}
});

alarm_create(5, function() {
	for (var i = 1; i <= global.player_max; i++) {
		if (focus_player_by_id(i).lost) {
			player_shot_time[i - 1] = get_frames(999);
		} else if (i == global.player_id) {
			trophy_obtain = false;
		}
	}

	while (array_count(player_can_shoot, true) > 0 || array_count(player_shot_time, 0) > 0) {
		alarm_frames(5, 1);
		return;
	}

	var rival_times = [
		player_shot_time[points_teams[0][0].network_id - 1] - player_shot_time[points_teams[1][0].network_id - 1],
		player_shot_time[points_teams[0][1].network_id - 1] - player_shot_time[points_teams[1][1].network_id - 1]
	];

	for (var i = 0; i < 2; i++) {
		var time = rival_times[i];
	
		if (time == 0) {
			for (var j = 0; j < 2; j++) {
				with (points_teams[j][i]) {
					player_kill();
				}
			}
		} else {
			with (points_teams[(time < 0)][i]) {
				player_kill();
			}
		
			with (points_teams[(time > 0)][i]) {
				minigame4vs_points(network_id, 1);
			}
		}
	}

	music_resume();
	alarm_call(6, 1);
	alarm_stop(10);
	take_time = false;
});

alarm_create(6, function() {
	if (minigame2vs2_get_points_team(0) >= point_condition || minigame2vs2_get_points_team(1) >= point_condition) {
		minigame_finish(true);
		return;
	}
	
	revive = 0;
});

alarm_create(7, function() {
	show_mark = false;
});

alarm_create(8, function() {
	fake_mark = false;
	next_seed_inline();
	var time = irandom_range(0.5, 1.5);
	cpu_shot_delay = [0];

	repeat (global.player_max - 1) {
		array_push(cpu_shot_delay, ceil(get_frames(random_range(time - 0.05, time + 0.6))));
	}

	music_resume();
	alarm_call(4, time);
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		if (--cpu_shot_delay[i - 1] == 0) {
			actions.shoot.press();
		}
	
		cpu_shot_delay[i - 1] = max(cpu_shot_delay[i - 1], 0);
	}

	alarm_frames(11, 1);
});