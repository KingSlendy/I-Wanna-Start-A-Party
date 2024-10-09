event_inherited();

if (trial_is_title(PERFECT_AIM)) {
	with (objMinigame4vs_Golf_Block) {
		if (x >= 224) {
			instance_destroy();
		}
	}
	
	layer_set_visible("Tiles", false);
}
