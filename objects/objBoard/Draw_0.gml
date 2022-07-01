var draw_player = function(player) {
	with (player) {
		if (draw && !lost) {
			event_perform(ev_draw, 0);
		}
	}
}

if (IS_BOARD) {
	if (!global.board_started) {
		for (var i = 1; i <= global.player_max; i++) {
			draw_player(focus_player_by_id(i));
		}
	} else {
		for (var i = 1; i <= global.player_max; i++) {
			if (i == global.player_turn) {
				continue;
			}
		
			draw_player(focus_player_by_turn(i));
		}
	
		draw_player(focus_player_by_turn());
	}
}
