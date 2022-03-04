switch (info.type) {
	case "4vs":
		winner_title = "A";
		break;
		
	case "2vs2":
		winner_title = (info.color_won == c_blue) ? "BLUE TEAM" : "RED TEAM";
		break;
}

show_popup(winner_title + "\nWON");