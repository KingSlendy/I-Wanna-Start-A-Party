if (fade_start) {
	fade_alpha = lerp(fade_alpha, 0.5, 0.1);
	stats_x = lerp(stats_x, stats_target_x, 0.2);
}

if (point_distance(stats_x, 0, stats_target_x, 0) < 0.5) {
	stats_x = stats_target_x;
}

if (!objResults.fade_start && show_inputs && stats_x == stats_target_x) {
	var scroll = (global.actions.right.pressed(global.player_id) - global.actions.left.pressed(global.player_id));

	if (scroll != 0) {
		if ((scroll < 0 && stats_page > 0) || (scroll > 0 && stats_page < stats_total_page)) {
			stats_target_x += (80 * 6) * -scroll;
			stats_page += scroll;
			audio_play_sound(global.sound_cursor_move, 0, false);
		}
	}
	
	if (global.actions.jump.pressed(1)) {
		with (objResults) {
			results_proceed();
		}
	}
}
