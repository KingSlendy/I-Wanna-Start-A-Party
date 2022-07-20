if (target_x != null) {
	objDiceRoll.follow_target_x = true;
	exit;
}

if (!global.board_started) {
	exit;
}

if (global.dice_roll > 0) {
	follow_x = true;
	follow_y = true;
	
	var rolled_same = true;
		
	with (objDiceRoll) {
		if (id == other.id) {
			continue;
		}
			
		if (roll != other.roll) {
			rolled_same = false;
			break;
		}
	}
	
	with (objDiceRoll) {
		if (by_item) {
			instance_destroy();
		}
	}
	
	roll = 0;
	
	if (!is_local_turn()) {
		exit;
	}
	
	if (player_info_by_id(network_id).item_effect == ItemType.TripleDice) {
		if (network_id == global.player_id) {
			if (global.dice_roll >= 25) {
				gain_trophy(20);
			} else if (global.dice_roll <= 10) {
				gain_trophy(21);
			}
		}
		
		if (rolled_same) {
			start_dialogue([
				new Message("What!!?? You rolled triples!!??\nThat's something you don't see everyday, you deserve this!",, function() {
					change_coins(30, CoinChangeType.Gain).final_action = board_advance;
				})
			]);
				
			if (network_id == global.player_id) {
				gain_trophy(36);
			}
				
			exit;
		}
	}
	
	if (player_info_by_id(network_id).item_effect == ItemType.DoubleDice) {
		if (rolled_same) {
			start_dialogue([
				new Message("What!? You rolled doubles!?\nNow that deserves a price.",, function() {
					change_coins(10, CoinChangeType.Gain).final_action = board_advance;
				})
			]);
				
			if (network_id == global.player_id) {
				gain_trophy(19);
			}
				
			exit;
		}
	}
	
	board_advance();
} else {
	if (is_local_turn()) {
		show_dice(network_id);
	}
}