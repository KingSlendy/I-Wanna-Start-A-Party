if (selecting) {
	var player = focus_player_by_turn(player_turn);
	var scroll = (global.actions.right.pressed(player.network_id) - global.actions.left.pressed(player.network_id));
	
	if (scroll != 0) {
		count = clamp(count + scroll, 0, 70);
		audio_play_sound(global.sound_cursor_move, 0, false);
	}
}