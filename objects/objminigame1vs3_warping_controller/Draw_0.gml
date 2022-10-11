event_inherited();

for (var i = 0; i < minigame1vs3_team_length(); i++) {
	var player = minigame1vs3_team(i);
	
	if (warp_delay[i] == 0) {
		draw_sprite(sprMinigame1vs3_Warping_Warp, 0, player.x - 17, player.y - 42);
	}
}