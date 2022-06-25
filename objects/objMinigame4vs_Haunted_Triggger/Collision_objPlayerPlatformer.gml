if (!other.won) {
	minigame4vs_points(other.network_id);
	minigame_finish(true);
	
	with (other) {
		frozen = true;
		hspeed = 3;
		sprite_index = skin[$ "Run"];
		won = true;
	}
}
