event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		guess_bugs_start = get_frames(random_range(5, 15)) * 0.1;
		
		if (0.25 > random(1)) {
			guess_total_bugs = other.total_bugs;
		} else {
			do {
				guess_total_bugs = irandom_range(other.total_bugs - 3, other.total_bugs + 3);
			} until (guess_total_bugs != other.total_bugs);
		}
	}
}

minigame_time = 30;
minigame_time_end = function() {
	with (objMinigame4vs_Bugs_Bug) {
		hspeed = 0;
		vspeed = 0;
		alarm_stop(0);
	}
	
	objMinigame4vs_Bugs_Counting.selecting = false;
	minigame_times_up();
	alarm_call(4, 2);
	
	with (objMinigame4vs_Bugs_Counting) {
		var player = focus_player_by_turn(player_turn);
		
		if (is_player_local(player.network_id)) {
			buffer_seek_begin();
			buffer_write_action(ClientTCP.Minigame4vs_Bugs_Counting);
			buffer_write_data(buffer_u8, player_turn);
			buffer_write_data(buffer_u8, count);
			network_send_tcp_packet();
		}
	}
}

player_type = objPlayerStatic;
bugs = [];
total_bugs = 0;
draw_top = false;
bug_counter = 0;

alarm_override(1, function() {
	alarm_inherited(1);
	objMinigame4vs_Bugs_Counting.selecting = true;
	draw_top = true;
	
	with (objMinigame4vs_Bugs_Bug) {
		alarm_frames(0, 1);
	}
});

alarm_create(4, function() {
	if (array_length(bugs) == 0) {
		alarm_call(5, 1);
		return;
	}

	bug_counter++;
	var bug = bugs[0];
	bug.counter = bug_counter;
	bug.state = 0;
	array_delete(bugs, 0, 1);
	audio_play_sound(sndMinigame4vs_Bugs_BugCount, 0, false);
	alarm_call(4, 0.5);
});

alarm_create(5, function() {
	var min_diff = infinity;

	for (var i = 1; i <= global.player_max; i++) {
		with (objMinigame4vs_Bugs_Counting) {
			if (i == player_turn) {
				min_diff = min(min_diff, abs(count - other.total_bugs));
				break;
			}
		}
	}

	with (objMinigame4vs_Bugs_Counting) {
		if (abs(count - other.total_bugs) == min_diff) {
			minigame4vs_points(focus_player_by_turn(player_turn).network_id);
		}
	}

	minigame_finish();
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);

		if (player.guess_bugs_start > 0) {
			player.guess_bugs_start--;
			continue;
		}
		
		if (0.1 > random(1)) {
			continue;
		}
	
		with (objMinigame4vs_Bugs_Counting) {
			var player = focus_player_by_turn(player_turn);
			
			if (player.network_id != i) {
				continue;
			}
			
			if (count < player.guess_total_bugs) {
				actions.right.press();
			} else if (count > player.guess_total_bugs) {
				actions.left.press();
			}
		}
	}
	
	alarm_call(11, 0.2);
});