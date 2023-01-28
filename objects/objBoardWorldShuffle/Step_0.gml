if (state == 0) {
	fade_alpha += 0.03;
	
	if (fade_alpha >= 1) {
		fade_alpha = 1;
		state = 1;
		var scott = null;
		
		if (is_player_turn()) {
			with (focused_player()) {
				scott = instance_place(x, y, objBoardWorldScott);
			}
		} else {
			scott = focused_player();
		}
		
		with (scott) {
			var spaces = [];
			
			with (objSpaces) {
				if ((image_index == SpaceType.Blue || image_index == SpaceType.Red) && !place_meeting(x, y, objPlayerBoard)) {
					array_push(spaces, id);
				}
			}
			
			next_seed_inline();
			array_shuffle(spaces);
			
			with (array_pop(spaces)) {
				other.x = x + 16;
				other.y = y + 16;
			}
		}
	}
} else if (state == 1) {
	fade_alpha -= 0.03;
	
	if (fade_alpha <= 0) {
		instance_destroy();
	}
}