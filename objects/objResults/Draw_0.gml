for (var i = 0; i < global.player_max; i++) {
	var color = player_color_by_turn(i + 1);
	draw_sprite_ext(sprPartyLightReflector, 0, 230 + 110 * i, 200, 1, 1, 10 * dsin(lights_angle[i]), color, 1);
	
	if (focus_player_by_turn(i + 1).lost) {
		continue;
	}
	
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(sprPartyLight, 0, 230 + 110 * i, 200, 1, 1, 10 * dsin(lights_angle[i]), color, 1);
	gpu_set_blendmode(bm_normal);
	
	if (lights_moving) {
		if (!revealed) {
			lights_angle[i] += lights_spd[i];
			lights_angle[i] %= 360;
		} else {
			lights_angle[i] = lerp(lights_angle[i], 0, 0.05);
		}
	}
}

for (var i = 1; i <= global.player_max; i++) {
	with (focus_player_by_turn(i)) {
		if (draw && !lost) {
			event_perform(ev_draw, 0);
		}
	}
}
