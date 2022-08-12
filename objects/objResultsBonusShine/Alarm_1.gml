if (global.player_id == 1) {
	var players = bonus.max_players();
	var names = "";

	for (var i = 1; i <= global.player_max; i++) {
		if (!array_contains(players, i)) {
			continue;
		}
		
		names += "{COLOR,0000FF}" + focus_player_by_turn(i).network_name + "{COLOR,FFFFFF}, "
	}

	names = string_copy(names, 1, string_length(names) - 2);
	var text = "";

	switch (array_length(players)) {
		case 1: text = "Congratulations!"; break;
		case 2: text = "I applaud both of you!"; break;
		case 3: text = "Wow, three of you got it!\nI'm impressed!"; break;
		case 4: text = "What!? All of you managed to get it??\nYou're all so good!"
	}

	start_dialogue([
		new Message(string_interp("{0}!\n{1}", names, text),, function() {
			with (objResultsBonusShine) {
				next_bonus();
			}
		})
	]);
}
