for (var i = 0; i < global.player_max; i++) {
	var color = player_color_by_turn(i + 1);
	draw_sprite_ext(sprPartyLightReflector, 0, 230 + 110 * i, 200, 1, 1, 0, color, 1);
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(sprPartyLight, 0, 230 + 110 * i, 200, 1, 1, 0, color, 1);
	gpu_set_blendmode(bm_normal);
}

for (var i = 1; i <= global.player_max; i++) {
	with (focus_player_by_id(i)) {
		event_perform(ev_draw, 0);
	}
}
