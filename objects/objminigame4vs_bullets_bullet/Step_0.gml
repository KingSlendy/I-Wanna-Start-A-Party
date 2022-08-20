x = approach(x, target_x, 4 * DELTA);

if (x <= 128 - sprite_width) {
	x = 128 + sprite_width * 4;
	target_x = x;
	change_index();
	
	if (objMinigame4vs_Bullets_Block.image_index == 0 || !objMinigameController.twice) {
		with (objMinigameController) {
			with (focus_player_by_turn(player_turn)) {
				jump_total = 2;
				player_jump();
			}
		}
		
		alarm_call(0, 0.4);
	} else {
		alarm_call(1, 0.4);
	}
}