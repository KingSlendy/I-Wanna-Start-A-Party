if (next_turn == 0) {
	alpha += 0.02;
	
	if (alpha >= 1) {
		alpha = 1;
		next_turn = 1;
		player_turn++;
		reposition_player();
	}
} else if (next_turn == 1) {
	alpha -= 0.02;
	
	if (alpha <= 0) {
		alpha = 0;
		next_turn = -1;
		unfreeze_player();
	}
}

if (next_turn != -1 || info.is_finished) {
	exit;
}

if (!instance_exists(objBullet) && player_bullets[player_turn - 1] == 0) {
	objPlayerBase.frozen = true;
	
	if (player_turn < global.player_max) {
		next_turn = 0;
	} else {
		minigame_finish();
	}
}