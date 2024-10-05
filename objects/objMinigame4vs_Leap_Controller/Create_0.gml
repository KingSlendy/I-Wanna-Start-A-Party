event_inherited();

minigame_camera = CameraMode.Split4;

player_type = objPlayerBasic;

input_actions = [
	"right",
	"up",
	"left",
	"down",
	"jump",
	"shoot"
];

input_buffers = [];

for (var i = 0; i < global.player_max; i++) {
	array_push(input_buffers, array_create(array_length(input_actions), 0));
}

show_input = false;
current_input = array_create(global.player_max, 0);
input_list = [];
stall_input = array_create(global.player_max, false);
reset_input = array_create(global.player_max, false);
prev_input = null;
block_separation = 96;
next_seed_inline();

for (var i = 0; i < 20; i++) {
	var input = null;
	
	do {
		input = input_actions[irandom(array_length(input_actions) - 1)];
	} until (input != prev_input);
	
	prev_input = input;
	array_push(input_list, input);
	
	for (var j = 0; j < global.player_max; j++) {
		if (i != 0) {
			instance_create_layer(96 + block_separation * i, 88 + 152 * j, "Collisions", objMinigame4vs_Leap_Block);
		}
	}
}

alarm_override(1, function() {
	show_input = true;
});