with (objPlayerBase) {
	change_to_object(objPlayerStatic);
}

event_inherited();

minigame_time = 10;
minigame_time_end = function() {
	if (!is_player_local(focus_player_by_turn(minigame_turn).network_id)) {
		return;
	}
	
	with (objMinigameController) {
		stop_input();
		correct = false;
		objMinigame4vs_Lead_Bubble.image_blend = c_red;
		event_perform(ev_alarm, 4);
	}
}

player_check = objPlayerStatic;
state = 0;
sequence_actions = [
	"right",
	"left",
	"down",
	"jump",
	"shoot"
];

sequence = [];

for (var i = 0; i < 4; i++) {
	array_push(sequence, irandom(array_length(sequence_actions) - 1));
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
		alarm[4] = get_frames(1);
		alarm[10] = 0;
		alarm[11] = get_frames(random_range(2, 3));
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
		alarm[4] = get_frames(1);
		alarm[10] = 0;
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
	alarm[10] = get_frames(1);
}
