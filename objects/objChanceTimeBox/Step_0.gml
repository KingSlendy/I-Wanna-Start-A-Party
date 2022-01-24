if (abs(yy) >= 32) {
	if (roulette) {
		yy += 32;
		var choices = [];
	
		for (var i = 0; i < array_length(sprites); i++) {
			array_push(choices, i);
		}
	
		array_shuffle(choices);
		var length = array_length(show_sprites);

		if (show_sprites[0] == null) {
			for (var i = 0; i < length; i++) {
				show_sprites[i] = sprites[choices[i]];
			}
		} else {
			for (var i = 0; i < length; i++) {
				if (i != length - 1) {
					show_sprites[i] = show_sprites[i + 1];
				} else {
					show_sprites[i] = sprites[choices[0]];
				}
			}
		}
	} else {
		yy = -32;
	}
}

yy -= 5;