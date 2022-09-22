if (other.network_id == global.player_id) {
	if (state == 0) {
		var t = instance_create_layer(96, 448, "Actors", objMinigame4vs_Haunted_Trophy);
		t.state = 1;
	} else {
		achieve_trophy(10);
	}
	
	instance_destroy();
}
