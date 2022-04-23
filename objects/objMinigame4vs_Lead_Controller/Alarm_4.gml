if (send_network) {
	//Send
}

var player = focus_player_by_turn(minigame_turn);

if (!correct) {
	with (focus_player_by_turn(minigame_turn)) {
		player_kill();
		lost = true;
		other.info.player_scores[network_id - 1].points = -1;
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

for (var i = 0; i < global.player_max; i++) {
	if (info.player_scores[i].points == -1) {
		lost_count++;
	}
}

if (lost_count == global.player_max - 1) {
	objMinigame4vs_Lead_Bubble.visible = false;
	minigame_4vs_points(info, player.network_id - 1);
	minigame_finish();
	exit;
}

next_player();
send_network = true;
