for (var i = 0; i < array_length(points_teams[0]); i++) {
	with (points_teams[0][i]) {
		hspeed = 0;
	}
}

with (objMinigame1vs3_Chase_Gradius) {
	image_index = 0;
	hspeed = 0;
}

next_seed_inline();

if (team_correct) {
	team_turn++;
	team_turn %= 3;
}

team_action = press_actions[irandom(array_length(press_actions) - 1)];
team_correct = false;
team_wrong = false;
