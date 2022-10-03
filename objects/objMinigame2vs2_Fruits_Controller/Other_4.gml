event_inherited();

for (var i = 1; i <= global.player_max; i++) {
	var player = focus_player_by_id(i);
	var b = instance_create_layer(player.x, player.y - 10, "Actors", objMinigame2vs2_Fruits_Basket);
	b.follow = player;
	player.basket = b;
}