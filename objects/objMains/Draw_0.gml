for (var i = 0; i < global.player_max; i++) {
	if (focus_player_by_id(i + 1).sprite_index == sprPlayerBlank) {
		continue;
	}
	
	var color = player_color_by_turn(i + 1);
	draw_sprite_ext(sprPartyLightReflector, 0, 230 + 110 * i, 200, 1, 1, 0, color, 1);
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(sprPartyLight, 0, 230 + 110 * i, 200, 1, 1, 0, color, 1);
	gpu_set_blendmode(bm_normal);
}

for (var i = 1; i <= global.player_max; i++) {
	with (focus_player_by_id(i)) {
		if (draw) {
			event_perform(ev_draw, 0);
		}
	}
}