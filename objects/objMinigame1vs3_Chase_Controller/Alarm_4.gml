with (points_teams[1][0]) {
	sprite_index = skin[$ "Idle"];
	hspeed = 0;
}

next_seed_inline();
solo_action = press_actions[irandom(array_length(press_actions) - 1)];
solo_correct = false;
solo_wrong = false;
