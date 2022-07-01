if (selecting) {
	var scroll = (global.actions.right.pressed(network_id) - global.actions.left.pressed(network_id));
	
	if (scroll != 0) {
		count = clamp(count + scroll, 0, 99);
		audio_play_sound(global.sound_cursor_move, 0, false);
	}
}