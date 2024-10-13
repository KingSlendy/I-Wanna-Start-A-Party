vspeed = -4;
gravity = 0.4;
roll = 0;
target_x = null;
follow_target_x = false;
follow_x = false;
follow_y = false;
by_item = (instance_number(object_index) > 1);

alarms_init(1);

alarm_create(function() {
	if (target_x != null) {
		objDiceRoll.follow_target_x = true;
		return;
	}

	if (!global.board_started) {
		return;
	}

	//An item was used so more dice are needed
	if (global.dice_roll <= 0) {
		if (is_local_turn()) {
			show_dice(network_id);
		}
		
		return;
	}
	
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
		return;
	}
	
	if (is_player_turn()) {
		var player_info = player_info_by_id(network_id);
		
		if (player_info.item_effect == ItemType.TripleDice) {
			if (network_id == global.player_id) {
				if (global.dice_roll >= 25) {
					achieve_trophy(20);
				} else if (global.dice_roll <= 10) {
					achieve_trophy(21);
				}
			}
		
			if (rolled_same) {
				start_dialogue([
					new Message(language_get_text("PARTY_ITEM_ROLLED_TRIPLES"),, function() {
						change_coins(50, CoinChangeType.Gain).final_action = board_advance;
					})
				]);
				
				if (network_id == global.player_id) {
					achieve_trophy(36);
				}
				
				return;
			}
		}
	
		if (player_info.item_effect == ItemType.DoubleDice) {
			if (rolled_same) {
				start_dialogue([
					new Message(language_get_text("PARTY_ITEM_ROLLED_DOUBLES"),, function() {
						change_coins(10, CoinChangeType.Gain).final_action = board_advance;
					})
				]);
				
				if (network_id == global.player_id) {
					achieve_trophy(19);
				}
				
				return;
			}
		}
	}
	
	roll_path_finding();
	board_advance();
});