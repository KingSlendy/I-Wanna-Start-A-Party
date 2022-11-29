event_inherited();

if (trial_is_title(COLORFUL_MADNESS)) {
	with (objMinigame2vs2_Colorful_Patterns) {
		if (x > 400) {
			instance_destroy();
		}
		
		x += 32 * 2;
		y -= 32 * 3;
		pattern_rows = 11;
		pattern_cols = 17;
	}
	
	layer_set_visible("Tiles", false);
	layer_set_visible("Tiles_2", true);
}