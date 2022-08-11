var up_number = -1;

with (objMinigame1vs3_Showdown_Block) {
	if (y < 304) {
		up_number = number;
		break;
	}
}

with (objMinigame1vs3_Showdown_Block) {
	if (y > 304 && number == up_number) {
		instance_destroy();
	}
}

with (objMinigame1vs3_Showdown_Rounds) {
	if (number == other.rounds) {
		image_index = 1;
		break;
	}
}

alarm[1] = get_frames(2);