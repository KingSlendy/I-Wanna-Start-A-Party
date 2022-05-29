next_seed_inline();
info = global.minigame_info;
objPlayerBase.frozen = true;
minigame_start = minigame_4vs_start;
minigame_split = false;
minigame_time = -1;
minigame_time_end = minigame_finish;
music = bgmMinigameA;
started = false;
announcer_started = false;
alpha = 1;
finished = false;
announcer_finished = false;
cleaned = false;
points_draw = false;
points_number = true;
points_teams = [];
player_check = objPlayerBase;

function back_to_board() {
	event_perform(ev_cleanup, 0);
	
	with (objPlayerInfo) {
		target_draw_x = main_draw_x;
		target_draw_y = main_draw_y;
		draw_x = target_draw_x;
		draw_y = target_draw_y;
	}
	
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
}
