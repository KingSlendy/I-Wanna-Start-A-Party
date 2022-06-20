var draw_player = function(player) {
	with (player) {
		if (draw && !lost) {
			event_perform(ev_draw, 0);
		}
	}
}

if (IS_BOARD) {
	var focus_player = (global.board_started) ? focus_player_by_turn : focus_player_by_id;
	
	for (var i = 1; i <= global.player_max; i++) {
		if (i == global.player_turn) {
			continue;
		}
		
		draw_player(focus_player(i));
	}
	
	draw_player(focus_player());
}
