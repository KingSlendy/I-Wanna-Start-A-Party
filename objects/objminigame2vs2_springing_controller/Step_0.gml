if (info.is_finished) {
	exit;
}
 
var player1 = focus_player_by_turn(1);
var player2 = focus_player_by_turn(3);

if (player1.lost && player1.teammate.lost) {
	minigame2vs2_points(player2.network_id, player2.teammate.network_id);
	minigame_finish();
}

if (player2.lost && player2.teammate.lost) {
	minigame2vs2_points(player1.network_id, player1.teammate.network_id);
	minigame_finish();
}