var draw_player = function(player) {
	with (player) {
		if (draw && !lost) {
			event_perform_object((is_player_local(network_id)) ? object_index : network_index, ev_draw, 0);
		}
	}
}

for (var i = 1; i <= global.player_max; i++) {
	if (i == global.player_id) {
		continue;
	}
		
	draw_player(focus_player_by_id(i));
}
	
draw_player(focus_player_by_id());