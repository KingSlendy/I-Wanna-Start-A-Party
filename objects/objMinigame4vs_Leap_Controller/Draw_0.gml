event_inherited();

if (!show_input) {
	exit;
}

var view = view_current;

for (var i = current_input[view]; i < array_length(input_list); i++) {
	if (i - current_input[view] > 5) {
		continue;
	}
	
	if (i == current_input[view] && stall_input[view] || i == array_length(input_list) - 1) {
		continue;
	}
		
	var input = input_list[i];
	var player = focus_player_by_turn(view + 1);
	draw_sprite_ext(global.actions[$ input].bind(), 0, 96 + 17 + block_separation * i, 88 - 54 + 152 * view, 0.5, 0.5, 0, (!invert_list[i]) ? c_white : #FF5E4F, 1);
}