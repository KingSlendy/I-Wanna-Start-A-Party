depth = layer_get_depth("Tiles_Back_Black") + 1;

function change_index() {
	next_seed_inline();
	
	with (objMinigameController) {
		other.image_index = (bullet_index != 0);

		if (++bullet_index > bullet_max) {
			bullet_index = 0;
			bullet_max = choose(1, 2);
		}
	}
}