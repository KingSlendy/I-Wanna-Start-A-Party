objTheGuy.alarm[5] = get_frames(1);

if (is_local_turn()) {
	options[global.choice_selected].action();
}
