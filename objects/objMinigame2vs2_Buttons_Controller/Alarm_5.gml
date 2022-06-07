var index = 0;

with (objMinigame2vs2_Buttons_Button) {
	if (!inside) {
		if (index == other.buttons_outside_list[other.buttons_outside_current]) {
			image_index = 1;
			other.buttons_outside_current++;
			break;
		}
		
		index++;
	}
}

//audio_play_sound(sndBlockChange, 0, false);
