if (state == 0) {
	fade_alpha += 0.03;
	
	if (fade_alpha >= 1) {
		fade_alpha = 1;
		state = 1;

		with (objBoardWorldGhost) {
			var spaces = [];
			
			with (objSpaces) {
				if ((image_index == SpaceType.Blue || image_index == SpaceType.Red) && !place_meeting(x, y, objPlayerBase)) {
					array_push(spaces, {x: self.x + 16, y: self.y + 16});
				}
			}
			
			array_sort(spaces, function(a, b) {
				return (a.x + a.y) - (b.x + b.y);
			});
			
			next_seed_inline();
			array_shuffle_ext(spaces);
			var space = array_pop(spaces);
			x = space.x;
			y = space.y;
		}
		
		global.player_turn = global.player_ghost_turn;
	}
} else if (state == 1) {
	fade_alpha -= 0.03;
	
	if (fade_alpha <= 0) {
		instance_destroy();
	}
}