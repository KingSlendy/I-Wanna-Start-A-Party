if (global.player_id != 1) {
	exit;
}

cpu_staled = false;
cpu_performed = false;
alarm[11] = 1;

var stale_action = function(seconds) {
	if (!cpu_wait || cpu_staled || cpu_performed) {
		return;
	}
	
	alarm[11] = get_frames(seconds);
	cpu_wait = false;
	cpu_staled = true;
}

var perform_action = function(action) {
	if (cpu_staled || cpu_performed) {
		return;
	}
	
	action.press();
	cpu_wait = true;
	cpu_performed = true;
}

var stale_frames = random_range(0.1, 0.3);

if (global.board_started) {
	var player_info = player_info_by_turn();
	var actions = check_player_actions_by_id(player_info.network_id);

	if (actions == null) {
		exit;
	}
	
	if (instance_exists(objTurnChoices) && objTurnChoices.can_choose()) {
		if (player_info.item_used != null) {
			cpu_item = -1;
		}
		
		if (cpu_item == -1 && player_info.item_used == null && array_count(player_info.items, null) < 3) {
			var use_percentage = array_create(3, 0);
				
			for (var i = 0; i < 3; i++) {
				var item = player_info.items[i];
			
				if (item == null || !item.use_criteria()) {
					continue;
				}
				
				if (global.board_turn == global.max_board_turns) {
					use_percentage[i] = 100;
				} else {
					use_percentage[i] = irandom_range(1, 100);
				}
			}
			
			var max_percentage = -infinity;
			
			for (var i = 0; i < 3; i++) {
				max_percentage = max(max_percentage, use_percentage[i]);
			}
				
			var most_percentage = [];
				
			for (var i = 0; i < 3; i++) {
				if (use_percentage[i] == max_percentage) {
					array_push(most_percentage, i);
				}
			}
				
			array_shuffle(most_percentage);
			cpu_item = most_percentage[0];
		}
		
		if (cpu_item == -1) {
			stale_action(stale_frames);
			
			if (objTurnChoices.option_selected == 0) {
				perform_action(actions.jump);
			} else {
				perform_action(actions.up);
			}
		} else {
			stale_action(stale_frames);
			
			if (objTurnChoices.option_selected == 0) {
				perform_action(actions.down);
			} else {
				perform_action(actions.jump);
			}
		}
	}
	
	if (instance_exists(objMultipleChoices)) {
		stale_action(stale_frames);
		
		if (global.item_choice) {
			if (global.choice_selected == cpu_item) {
				perform_action(actions.jump);
			} else {
				perform_action(actions.right);
			}
		}
	}
	
	if (instance_exists(objBox)) {
		stale_action(random_range(0.5, 1.5));
		perform_action(actions.jump);
	}
	
	if (instance_exists(objPathChange)) {
		perform_action(actions.jump);
	}
	
	//if (instance_exists(objDialogue)) {
	//	if (!objDialogue.text_display.text.tw_active) {
	//		stale_action(1);
	//		perform_action(actions.jump);
	//	} else {
	//		perform_action(actions.jump);
	//	}
	//}

	var keys = variable_struct_get_names(actions);
	perform_action(actions[$ keys[irandom(array_length(keys) - 1)]]);
} else if (!instance_exists(objDialogue)) {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);
		
		if (actions == null) {
			continue;
		}
		
		actions.jump.press();
	}
}