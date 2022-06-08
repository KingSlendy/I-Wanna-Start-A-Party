if (!other.won) {
	minigame_4vs_points(objMinigameController.info, other.network_id);
	minigame_finish(true);
	
	with (other) {
		frozen = true;
		hspeed = 3;
		sprite_index = skin[$ "Run"];
		won = true;
	}
}
