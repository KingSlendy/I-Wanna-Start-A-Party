with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_move = false;
	lost = false;
}

event_inherited();

player_check = objPlayerPlatformer;
minigame_4vs_start();
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
send_network = true;

function stop_input() {
	current = 0;
	
	with (objPlayerBase) {
		frozen = true;
		enable_jump = false;
		enable_shoot = false;
	}
}

function next_player() {
	stop_input();
	var player = focus_player_by_turn(minigame_turn);
	
	with (player) {
		frozen = false;
		enable_jump = true;
		enable_shoot = true;
	}
}
