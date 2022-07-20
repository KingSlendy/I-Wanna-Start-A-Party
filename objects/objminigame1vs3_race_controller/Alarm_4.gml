with (points_teams[1][0]) {
	sprite_index = skin[$ "Idle"];
	hspeed = 0;
}

solo_current++;
solo_current %= array_length(solo_actions);
solo_action = solo_actions[solo_current];
solo_correct = false;
solo_wrong = false;