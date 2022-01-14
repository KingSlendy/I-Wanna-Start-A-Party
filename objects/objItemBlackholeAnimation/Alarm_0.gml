turn_previous = global.player_turn;
global.player_turn = global.choice_selected + 1;
player_turn_info = get_player_turn_info();
steal_count = clamp(player_turn_info.coins, 0, 20);

switch_camera_target(current_player.x, current_player.y).final_action = function() {
	if (is_player_turn()) {
		var text;
	
		switch (additional) {
			case 0:
				text = "The blackhole is gonna steal your coins!\nMash as fast as you can to reduce the amount!";
				break;
			
			case 1:
				text = "Oh no!\nThe blackhole is gonna steal a shine!";
				break;
		}
	
		start_dialogue([
			new Message(text,, start_blackhole_steal)
		]);
	}
}