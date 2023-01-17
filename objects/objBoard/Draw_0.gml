var draw_player = function(player) {
	with (player) {
		if (draw && !lost) {
			event_perform(ev_draw, 0);
		}
	}
}

if (IS_BOARD) {
	var max_turns = (room != rBoardWorld) ? global.player_max : global.player_max + 2;
	
	if (!global.board_started) {
		for (var i = 1; i <= max_turns; i++) {
			draw_player(focus_player_by_id(i));
		}
	} else {
		for (var i = 1; i <= max_turns; i++) {
			if (i == global.player_turn) {
				continue;
			}
		
			draw_player(focus_player_by_turn(i));
		}
	
		draw_player(focus_player_by_turn());
	}
}