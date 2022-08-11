var giver = instance_place(x, y, objMinigame4vs_Magic_GiverID);

if (giver != noone && giver.player_turn != 0) {
	player = focus_player_by_turn(giver.player_turn);
}