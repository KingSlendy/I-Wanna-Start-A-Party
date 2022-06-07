if (is_local_turn()) {
	objTheGuy.alarm[5] = get_frames(1);
	options[global.choice_selected].action();
}
