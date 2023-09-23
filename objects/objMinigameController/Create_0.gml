fade_alpha = 1;
info = global.minigame_info;
shuffle_seed_bag();
reset_seed_inline();
minigame_info_score_reset();
music_stop();

with (objPlayerBase) {
	draw = true;
	frozen = true;
}

minigame_start = minigame4vs_start;
minigame_players = function() {}
minigame_camera = CameraMode.Static;
minigame_time = 300;
minigame_time_halign = fa_center;
minigame_time_valign = fa_bottom;
minigame_time_end = minigame_finish;
action_end = function() {}
var name = room_get_name(room);
music = audio_get_index($"bgm{string_copy(name, 2, string_length(name) - 1)}");
started = false;
announcer_started = false;
finished = false;
announcer_finished = false;
points_draw = false;
points_number = true;
points_teams = [];
player_type = objPlayerBase;
practice_alpha = 1;
practice_text = new Text(global.fntPopup);

function back_to_overview(network = true) {
	room_goto(rMinigameOverview);
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.MinigameOverviewReturn);
		network_send_tcp_packet();
	}
}

function back_to_board() {
	if (info.is_practice) {
		back_to_overview(false);
		return;
	}
	
	if (info.is_minigames) {
		if (minigame_has_won()) {
			change_collected_coins(20);
		}
			
		save_file();
		disable_board();
		room_goto(rMinigames);
		return;
	}
	
	if (info.is_trials) {
		trial_start();
		return;
	}
	
	if (++global.board_turn > global.max_board_turns) {
		board_finish();
		return;
	}
	
	global.player_turn = 1;
	
	with (objPlayerInfo) {
		target_draw_x = main_draw_x;
		target_draw_y = main_draw_y;
		draw_x = target_draw_x;
		draw_y = target_draw_y;
	}
	
	room_goto(info.previous_board);
}

function retry_trial() {
	trial_restart();
}

alarms_init(12);

alarm_create(function() {
	show_popup(language_get_text("MINIGAMES_START"),,,,,, 0.5);
	announcer_started = true;
	music_play(music, true);
	audio_play_sound(sndMinigameStart, 0, false);
	alarm_call(1, 0.5);

	if (minigame_time != -1) {
		alarm_call(10, 1);
	}

	if (global.player_id == 1) {
		alarm_frames(11, 1);
	}
});

alarm_create(function() {
	objPlayerBase.frozen = false;
});

alarm_create(function() {
	var winner_title = "";
	var loser_count = 0;

	for (var i = 0; i < global.player_max; i++) {
		loser_count += (info.player_scores[i].points <= 0);
	}
	
	if (!info.is_trials) {
		var loser_count = 0;

		for (var i = 0; i < global.player_max; i++) {
			loser_count += (info.player_scores[i].points <= 0);
		}
	
		if (array_length(info.players_won) > 0 && loser_count < global.player_max) {
			for (var i = 0; i < array_length(info.players_won); i++) {
				var player = focus_player_by_id(info.players_won[i]);
				winner_title += player.network_name + "\n";
			}
		
			winner_title += language_get_text("MINIGAMES_WON");
			music_play(bgmMinigameWin, false);
			audio_play_sound((array_length(info.players_won) == 1) ? sndMinigameWinner : sndMinigameWinners, 0, false);
		} else {
			info.players_won = [];
			winner_title = language_get_text("MINIGAMES_TIE");
			music_play(bgmMinigameTie, false);
			audio_play_sound(sndMinigameTie, 0, false);
			achieve_trophy(9);
		}

		if (!info.is_practice) {
			for (var i = 0; i < array_length(info.players_won); i++) {
				bonus_shine_by_id(BonusShines.MostMinigames).increase_score(player_info_by_id(info.players_won[i]).turn);
			}
		}
	} else {
		if (minigame_has_won()) {
			winner_title = language_get_text("MINIGAMES_CLEAR");
			music_play(bgmMinigameWin, false);
			audio_play_sound(sndMinigameClear, 0, false);
		} else {
			winner_title = language_get_text("MINIGAMES_TOO_BAD");
			music_play(bgmMinigameTie, false);
			audio_play_sound(sndMinigameTooBad, 0, false);
		}
	}

	show_popup(winner_title,,,,,, 3.5);
	alarm_call(3, 4);
});

alarm_create(function() {
	finished = true;
});

alarm_create(10, function() {
	if (--minigame_time <= 5) {
		audio_play_sound(sndMinigameCountdown, 0, false);
	}

	if (minigame_time <= 0) {
		minigame_time = 0;
	
		if (!info.is_finished) {
			minigame_time_end();
		}
	
		return;
	}
		
	alarm_call(10, 1);
});

alarm_create(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var keys = variable_struct_get_names(actions);
		var action = actions[$ keys[irandom(array_length(keys) - 1)]];
		
		switch (irandom(2)) {
			case 0:
				action.hold(irandom(21));
				break;
				
			case 1:
				action.press();
				break;
				
			case 2:
				action.release(true);
				break;
		}
	}

	alarm_frames(11, 1);
});