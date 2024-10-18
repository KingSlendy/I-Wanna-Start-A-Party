event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		press_delay = get_frames(random_range(0.75, 1.25));
	}
}

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
invert_list = [];
stall_input = array_create(global.player_max, false);
reset_input = array_create(global.player_max, 0);
prev_input = null;
block_total = 30;
block_separation = 96;
next_seed_inline();

for (var i = 0; i < block_total; i++) {
	var input = null;
	
	do {
		input = input_actions[irandom(array_length(input_actions) - 1)];
	} until (input != prev_input);
	
	prev_input = input;
	array_push(input_list, input);
	array_push(invert_list, (chance(0.35)) ? true : false);
	
	for (var j = 0; j < global.player_max; j++) {
		if (i != 0) {
			var b = instance_create_layer(96 + block_separation * i, 88 + 152 * j, "Collisions", objMinigame4vs_Leap_Block);
			
			if (i == block_total - 1) {
				b.image_blend = make_color_hsv(40, 100, 67);
			}
		}
	}
}

alarm_override(1, function() {
	show_input = true;
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);
		
		with (player) {
			var turn = player_info_by_id(network_id).turn;
			
			if (!other.show_input || other.stall_input[turn - 1] || press_delay > 0) {
				press_delay--;
				break;
			}
			
			var action = null;
		
			if (irandom(19) != 0 && !other.invert_list[other.current_input[turn - 1]]) {
				action = actions[$ other.input_list[other.current_input[turn - 1]]];
			} else {
				action = actions[$ other.input_actions[irandom(array_length(other.input_actions) - 1)]];
			}
		
			if (action != null) {
				action.press();
				press_delay = get_frames(random_range(0.3, 0.6));
			}
		}
	}

	alarm_frames(11, 1);
});