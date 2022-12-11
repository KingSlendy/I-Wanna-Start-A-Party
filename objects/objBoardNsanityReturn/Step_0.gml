if (state == 0) {
	fade_alpha += 0.03;
	
	if (fade_alpha >= 1) {
		fade_alpha = 1;
		state = 1;
		
		with (focused_player()) {
			with (objSpaces) {
				if (image_index == SpaceType.Start) {
					other.x = x + 16;
					other.y = y + 16;
					break;
				}
			}
		}
	}
} else if (state == 1) {
	fade_alpha -= 0.03;
	
	if (fade_alpha <= 0) {
		instance_destroy();
	}
}