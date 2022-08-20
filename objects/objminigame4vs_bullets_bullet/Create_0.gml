depth = layer_get_depth("Tiles_Back_Black") + 1;
target_x = x;

alarms_init(2);

alarm_create(function() {
	with (objMinigameController) {
		with (focus_player_by_turn(player_turn)) {
			player_jump();
			jump_total = 1;
		}
	}
	
	alarm_call(1, 1);
});

alarm_create(function() {
	with (objMinigameController) {
		if (objMinigame4vs_Bullets_Block.image_index == 1 && twice) {
			twice = false;
			bullets_move();
		} else {
			with (focus_player_by_turn(player_turn)) {
				hspd = max_hspd;
			}
			
			objMinigame4vs_Bullets_Block.spin = true;
			next_player();
		}
	}
});

function change_index() {
	with (objMinigameController) {
		other.image_index = bullet_indexes[bullet_current++];
	}
}