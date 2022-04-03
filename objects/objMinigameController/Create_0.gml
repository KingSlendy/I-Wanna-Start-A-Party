next_seed_inline();
info = global.minigame_info;
objPlayerBase.frozen = true;
started = false;
alpha = 1;
finished = false;
cleaned = false;

function back_to_board() {
	event_perform(ev_cleanup, 0);
	
	if (!info.is_practice) {
		if (++global.board_turn > global.max_board_turns) {
			board_finish();
			return;	
		}
		
		room_goto(info.previous_board);
	
		with (objPlayerBase) {
			change_to_object(objPlayerBoard);
		}
	} else {
		room_goto(rMinigameOverview);
	
		with (objPlayerBase) {
			change_to_object(objPlayerBase);
		}
		
		return;
	}

	with (objPlayerInfo) {
		target_draw_x = main_draw_x;
		target_draw_y = main_draw_y;
		draw_x = target_draw_x;
		draw_y = target_draw_y;
	}
}