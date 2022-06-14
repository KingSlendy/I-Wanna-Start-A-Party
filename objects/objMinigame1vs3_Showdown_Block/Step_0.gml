if (selecting) {
	var scroll = (global.actions.right.pressed(player_id) - global.actions.left.pressed(player_id));
	
	if (scroll != 0) {
		show = (show + 3 + scroll) % 3;
		audio_play_sound(global.sound_cursor_move, 0, false);
	}
	
	if (global.actions.jump.pressed(player_id)) {
		number = show;
	}
}
