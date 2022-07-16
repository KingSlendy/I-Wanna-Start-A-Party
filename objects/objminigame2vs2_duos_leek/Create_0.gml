function button_event() {
	image_xscale += 0.05;
	image_yscale += 0.05;
	
	if (image_xscale >= 3) {
		image_xscale = 3;
		image_yscale = 3;
		var player_id;
		
		switch (trg) {
			case 9: player_id = 1; break;
			case 8: player_id = 2; break;
			case 11: player_id = 3; break;
			case 10: player_id = 4; break;
		}
		
		var player = focus_player_by_id(player_id);
		player.finished = true;
	}
}