music_play(bgmPartyStar, true);
revealed = true;

if (global.player_id == 1) {
	var count = 0;
	var winners = "";
	
	with (objPlayerBase) {
		if (lost) {
			continue;
		}
		
		winners += string_interp("{COLOR,0000FF}{0}{COLOR,FFFFFF}, ", network_name);
		count++;
	}
	
	winners = string_copy(winners, 1, string_length(winners) - 2);
	var text = "";
	
	switch (count) {
		case 1: text = string_interp("{0} is the winner!\nA round of applause!", winners); break;
		case 2: text = string_interp("{0} are the winners!\nA double win, you don't see that very often!", winners); break;
		case 3: text = string_interp("{0} are the winners!\nI can hardly believe my eyes!\nThree of you won!", winners); break;
		case 4: text = string_interp("{0} are the winners!\nEveryone won???\nThat's even rarer than seeing a flying star!!!", winners); break;
	}
	
	start_dialogue([
		new Message(text,, results_end)
	]);
}
