x = approach(x, target_x, 4 * DELTA);

if (x <= 112 - sprite_width) {
	x = 112 + sprite_width * (instance_number(object_index) - 1);
	target_x = x;
	change_index();
	
	if (objMinigame4vs_Bullets_Block.image_index == 0 || !objMinigameController.twice) {
		with (objMinigameController) {
			with (focus_player_by_turn(player_turn)) {
				if (!is_player_local(network_id)) {
					break;
				}
				
				jump_total = 2;
				player_jump();
			}
		}
		
		alarm_call(0, 0.4);
	} else {
		alarm_call(1, 0.4);
	}
}