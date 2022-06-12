var draw_player = function(player) {
	with (player) {
		if (draw && !lost) {
			event_perform(ev_draw, 0);
		}
	}
}

if (IS_BOARD && global.board_started) {
	for (var i = 1; i <= global.player_max; i++) {
		if (i == global.player_turn) {
			continue;
		}
		
		draw_player(focus_player_by_turn(i));
	}
	
	draw_player(focus_player_by_turn());
} else {
	for (var i = 1; i <= global.player_max; i++) {
		if (i == global.player_id) {
			continue;
		}
		
		draw_player(focus_player_by_id(i));
	}
	
	draw_player(focus_player_by_id());
}
