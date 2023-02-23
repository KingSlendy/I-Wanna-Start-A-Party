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
				if ((image_index == SpaceType.Blue || image_index == SpaceType.Red) && !place_meeting(x, y, objPlayerBase)) {
					array_push(spaces, {x: self.x + 16, y: self.y + 16});
				}
			}
			
			array_sort(spaces, function(a, b) {
				return (a.x + a.y) - (b.x + b.y);
			});
			
			set_seed_inline(4872);
			array_shuffle_ext(spaces);
			var space = array_pop(spaces);
			x = space.x;
			y = space.y;
		}
	}
} else if (state == 1) {
	fade_alpha -= 0.03;
	
	if (fade_alpha <= 0) {
		instance_destroy();
	}
}