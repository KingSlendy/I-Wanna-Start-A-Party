var input = network_inputs[0];

if (input.input_player_id != focus_player_by_turn(minigame_turn).network_id) {
	alarm[5] = 1;
	exit;
}

check_input(input.input_input_id, false);
array_delete(network_inputs, 0, 1);

if (array_length(network_inputs) > 0) {
	alarm[5] = get_frames(0.25);
}
