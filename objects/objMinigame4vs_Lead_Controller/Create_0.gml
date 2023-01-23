event_inherited();

minigame_time = 10;
minigame_time_end = function() {
	with (objMinigameController) {
		stop_input();
		correct = false;
		objMinigame4vs_Lead_Bubble.image_blend = c_red;
		alarm_instant(4);
	}
}

player_type = objPlayerStatic;
state = 0;
sequence_actions = [
	"right",
	"left",
	"down",
	"jump",
	"shoot"
];

sequence = [];
var choose_current = 0;
var choose_previous = 0;

for (var i = 0; i < 4; i++) {
	do {
		choose_current = irandom(array_length(sequence_actions) - 1);
	} until (choose_current != choose_previous);
	
	array_push(sequence, choose_current);
	choose_previous = choose_current;
}

allowed = false;
minigame_turn = 1;
correct = false;
current = 0;
stopped = true;
network_inputs = [];

function check_input(input_id, network = true) {
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Lead_Input);
		buffer_write_data(buffer_u8, focus_player_by_turn(minigame_turn).network_id);
		buffer_write_data(buffer_u8, input_id);
		network_send_tcp_packet();
	}
	
	objMinigame4vs_Lead_Bubble.action_shown = input_id;
	audio_play_sound(sndCursorSelect, 0, false);
			
	if (current == array_length(sequence)) {
		stop_input();
		correct = true;
		array_push(sequence, input_id);
		alarm_call(4, 1);
		alarm_stop(10);
		alarm_call(11, random_range(2, 3));
		return;
	}
	
	if (sequence[current] == input_id) {
		current++;
				
		if (current == array_length(sequence)) {
			objMinigame4vs_Lead_Bubble.image_blend = c_yellow;
		}
	} else {
		stop_input();
		correct = false;
		objMinigame4vs_Lead_Bubble.image_blend = c_red;
		alarm_call(4, 1);
		alarm_stop(10);
	}
}

function stop_input() {
	current = 0;
	stopped = true;
}

function next_player() {
	stop_input();
	stopped = false;
	var player = focus_player_by_turn(minigame_turn);
	
	with (objMinigame4vs_Lead_Bubble) {
		image_blend = c_white;
		x = player.x;
		y = player.y + 10;
	}
	
	minigame_time = 10;
	alarm_call(10, 1);
}

alarm_override(0, function() {
	if (state++ == 1) {
		alarm_inherited(0);
	} else {
		with (objMinigame4vs_Lead_DeDeDe) {
			alarm_frames(0, 1);
		}
	}
});

alarm_override(1, function() {
	allowed = true;
	objMinigame4vs_Lead_Bubble.visible = true;
	next_player();
});

alarm_create(4, function() {
	var player = focus_player_by_turn(minigame_turn);

	if (!correct) {
		with (focus_player_by_turn(minigame_turn)) {
			player_kill();
			lost = true;
		}
	}

	do {
		if (++minigame_turn > global.player_max) {
			minigame_turn = 1;
		}
	
		player = focus_player_by_turn(minigame_turn);
	} until (!player.lost);

	objMinigame4vs_Lead_Bubble.action_shown = -1;
	var lost_count = 0;

	with (objPlayerBase) {
		lost_count += lost;
	}

	if (lost_count == global.player_max - 1) {
		objMinigame4vs_Lead_Bubble.visible = false;
		minigame4vs_points(player.network_id);
		minigame_finish();
		return;
	}

	next_player();
});

alarm_create(9, function() {
	var input = network_inputs[0];

	if (input.input_player_id != focus_player_by_turn(minigame_turn).network_id) {
		alarm_frames(9, 1);
		return;
	}

	check_input(input.input_input_id, false);
	array_delete(network_inputs, 0, 1);

	if (array_length(network_inputs) > 0) {
		alarm_call(9, 0.25);
	}
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		if (current < array_length(sequence) && irandom(max(24 - array_length(sequence), 1)) != 0) {
			actions[$ sequence_actions[sequence[current]]].press();
		} else {
			actions[$ sequence_actions[irandom(array_length(sequence_actions) - 1)]].press();
		}
	}

	alarm_call(11, 0.3);
});