var index = 0;

with (objMinigame1vs3_Buttons_Button) {
	if (inside) {
		if (index == other.buttons_inside_list[other.buttons_inside_current]) {
			image_index = 1;
			other.buttons_inside_current++;
			break;
		}
		
		index++;
	}
}

//audio_play_sound(sndBlockChange, 0, false);
