event_inherited();

if (!show_input) {
	exit;
}

for (var i = 0; i < global.player_max; i++) {
	for (var j = current_input[i]; j < array_length(input_list); j++) {
		if (j == current_input[i] && stall_input[i] || j == array_length(input_list) - 1) {
			continue;
		}
		
		var input = input_list[j];
		var player = focus_player_by_turn(i + 1);
		draw_sprite_ext(global.actions[$ input].bind(), 0, 96 + 17 + block_separation * j, 88 - 54 + 152 * i, 0.5, 0.5, 0, c_white, 1);
	}
}