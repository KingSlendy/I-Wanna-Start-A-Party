alarm[11] = 2;

if (global.player_id != 1) {
	exit;
}

var stale_action = function(seconds) {
	if (cpu_wait) {
		alarm[11] = get_frames(seconds);
		cpu_wait = false;
		exit;
	}
}

var perform_action = function(action) {
	action.press();
	cpu_wait = true;
	exit;
}

if (global.board_started) {
	var player_info = player_info_by_turn();
	var actions = check_player_actions_by_id(player_info.network_id);

	if (actions == null) {
		exit;
	}
	
	if (instance_exists(objTurnChoices) && objTurnChoices.can_choose()) {
		var use_items = (array_count(player_info.items, null) < 3);
		
		for (var i = 0; i < array_length(player_info.items); i++) {
			var item = player_info.items[i];
			
			if (item != null && !item.use_criteria()) {
				use_items = false;
				break;
			}
		}
		
		if (!use_items) {
			stale_action(1);
			perform_action(actions.jump);
		} else {
			stale_action(1);
			
			if (objTurnChoices.option_selected == 0) {
				perform_action(actions.down);
			} else {
				perform_action(actions.jump);
			}
		}
	}
	
	if (instance_exists(objBox)) {
		stale_action(irandom_range(2, 4));
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
} else {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);
		
		if (actions == null) {
			continue;
		}
		
		actions.jump.press();
	}
}