var winner_title = "";

switch (info.type) {
	case "4vs":
		for (var i = 0; i < array_length(info.players_won); i++) {
			var player = focus_player_by_id(info.players_won[i]);
			winner_title += player.network_name + "\n";
		}
		
		winner_title += "WON";
		break;
		
	case "1vs3":
	case "2vs2":
		if (info.color_won != c_white) {
			winner_title = (info.color_won == c_blue) ? "BLUE TEAM\nWON" : "RED TEAM\nWON";
		} else {
			winner_title = "TIE";
		}
		break;
}

show_popup(winner_title);
alarm[3] = get_frames(2);