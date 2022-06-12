var giver = instance_place(x, y, objMinigame4vs_Magic_GiverID);

if (giver != noone) {
	player_turn = giver.player_turn;
	player = focus_player_by_turn(player_turn);
}
