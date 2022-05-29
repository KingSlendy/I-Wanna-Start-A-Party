gpu_set_blendmode(bm_add);

for (var i = 0; i < global.player_max; i++) {
	if (focus_player_by_turn(i + 1).lost) {
		continue;
	}
	
	draw_sprite_ext(testsprLight, 0, 230 + 110 * i, 200, 1, 1, 0, player_color_by_turn(i + 1), 1);
}

gpu_set_blendmode(bm_normal);
