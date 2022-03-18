var winner_title = "";

switch (info.type) {
	case "4vs":
		winner_title = "A";
		break;
		
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