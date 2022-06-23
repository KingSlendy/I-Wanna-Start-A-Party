if (!started && get_player_count(player_check) == global.player_max) {
	alpha -= 0.03;
	
	if (alpha <= 0) {
		alpha = 0;
		started = true;
		alarm[0] = get_frames(1);
	}
}

if (finished) {
	alpha += 0.03;
	
	if (alpha >= 1) {
		alpha = 1;
		finished = false;
		back_to_board();
	}
}

if (info.is_modes && !info.is_finished && alpha == 0 && !IS_ONLINE && global.actions.back.pressed(1)) {
	with (objPlayerBase) {
		change_to_object(objPlayerBase);
	}
	
	room_goto(rMinigameOverview);
}
