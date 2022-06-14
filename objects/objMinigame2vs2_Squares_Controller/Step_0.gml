for (var i = 0; i < array_length(info.player_colors); i++) {
	var go = true;
	
	with (objMinigame2vs2_Squares_Halfs) {
		if (color == other.info.player_colors[i] && point_distance(image_angle, 0, 90, 0) > 6) {
			go = false;
			break;
		}
	}
	
	if (!go) {
		continue;
	}
	
	with (objMinigame2vs2_Squares_Halfs) {
		if (color == other.info.player_colors[i]) {
			image_angle = 90;
			target_y = 304;
			done = true;
		}
	}
}
