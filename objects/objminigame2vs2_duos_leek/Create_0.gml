function button_event() {
	image_xscale += 0.09;
	image_yscale += 0.09;
	
	if (image_xscale >= 3) {
		image_xscale = 3;
		image_yscale = 3;
		var player;
		
		switch (trg) {
			case 9: player = objMinigameController.points_teams[0][0]; break;
			case 8: player = objMinigameController.points_teams[0][1]; break;
			case 11: player = objMinigameController.points_teams[1][0]; break;
			case 10: player = objMinigameController.points_teams[1][1]; break;
		}
		
		player.finished = true;
	}
}