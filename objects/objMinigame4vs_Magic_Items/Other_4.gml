giver = instance_place(x, y, objMinigame4vs_Magic_GiverID);

if (giver != noone && giver.player_turn != 0) {
	player_turn = giver.player_turn;
	player = focus_player_by_turn(player_turn);
}

with (instance_create_layer(x, y, "Actors", objMinigame4vs_Magic_Holder)) {
	order = other.order;
	
	if (other.player != null) {
		network_id = other.player.network_id;
	}
}
