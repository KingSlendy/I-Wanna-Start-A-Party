var player = focus_player_by_turn(minigame_turn);

if (!correct) {
	with (focus_player_by_turn(minigame_turn)) {
		player_kill();
		lost = true;
	}
}

do {
	if (++minigame_turn > global.player_max) {
		minigame_turn = 1;
	}
	
	player = focus_player_by_turn(minigame_turn);
} until (!player.lost);

objMinigame4vs_Lead_Bubble.action_shown = -1;
var lost_count = 0;

with (objPlayerBase) {
	lost_count += lost;
}

if (lost_count == global.player_max - 1) {
	objMinigame4vs_Lead_Bubble.visible = false;
	minigame_4vs_points(other.info, player.network_id);
	minigame_finish();
	exit;
}

next_player();
