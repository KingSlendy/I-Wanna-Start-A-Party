minigame_info_placement();

for (var i = 0; i < global.player_max; i++) {
	var player_info = places_minigame_info[i];
	var order = places_minigame_order[i];
			
	with (player_info) {
		target_draw_x = 400 - draw_w / 2;
		target_draw_y = 79 + (draw_h + 30) * (order - 1);
	}
}

alarm[3] = get_frames(1.5);