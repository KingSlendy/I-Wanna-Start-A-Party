with (objPlayerBase) {
	change_to_object(objPlayerStatic);
}

event_inherited();

minigame_time = 30;
minigame_time_end = function() {
	with (objMinigame4vs_Bugs_Bug) {
		hspeed = 0;
		vspeed = 0;
		alarm_stop(0);
	}
	
	objMinigame4vs_Bugs_Counting.selecting = false;
	
	with (objMinigame4vs_Bugs_Bug) {
		if (sprite_index == other.count_bug) {
			array_push(other.bugs, id);
		}
	}
	
	total_bugs = array_length(bugs);
	minigame_times_up();
	alarm_call(4, 2);
	
	with (objMinigame4vs_Bugs_Counting) {
		if (is_player_local(network_id)) {
			buffer_seek_begin();
			buffer_write_action(ClientTCP.Minigame4vs_Bugs_Counting);
			buffer_write_data(buffer_u8, network_id);
			buffer_write_data(buffer_u8, count);
			network_send_tcp_packet();
		}
	}
}

player_check = objPlayerStatic;
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
			if (i == network_id) {
				min_diff = min(min_diff, abs(count - other.total_bugs));
				break;
			}
		}
	}

	with (objMinigame4vs_Bugs_Counting) {
		if (abs(count - other.total_bugs) == min_diff) {
			minigame4vs_points(network_id);
		}
	}

	minigame_finish();
});

alarm_override(11, function() {
	if (global.player_id != 1) {
		return;
	}

	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var action = choose(actions.left, actions.right);
		action.press();
	}
	
	alarm_call(11, 0.5);
});