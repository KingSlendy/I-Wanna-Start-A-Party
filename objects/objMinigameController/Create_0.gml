info = global.minigame_info;
objPlayerBase.frozen = true;
started = false;
alpha = 1;
finished = false;
signal_finished = true;
cleaned = false;

function back_to_board() {
	event_perform(ev_cleanup, 0);
	room_goto(info.previous_board);
	
	with (objPlayerBase) {
		change_to_object(objPlayerBoard);
	}

	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_id(i);
		var pos = info.player_positions[i - 1];
		player.x = pos.x;
		player.y = pos.y;
	}
	
	with (objPlayerInfo) {
		target_draw_x = main_draw_x;
		target_draw_y = main_draw_y;
		draw_x = target_draw_x;
		draw_y = target_draw_y;
	}
}