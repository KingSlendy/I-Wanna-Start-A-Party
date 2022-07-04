function press_button() {
	image_index = 1;
	alarm[0] = get_frames(0.1);
	
	with (objMinigame2vs2_Duos_Block) {
		if (trg == other.trg) {
			button_event();
		}
	}
	
	with (objMinigame2vs2_Duos_Platform) {
		if (trg == other.trg) {
			button_event();
		}
	}
}