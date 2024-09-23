event_inherited();

with (objPlayerBase) {
	if (coin_can_toss) {
		var sprite = sprMinigame2vs2_Stacking_CoinBounce;
		draw_sprite(sprite, other.timer * sprite_get_speed(sprite) / game_get_speed(gamespeed_fps), x - sprite_get_width(sprite) / 2, y - 35);
	}
}