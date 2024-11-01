switch (room) {
	case rBoardBaba:
		tile_image_index += tile_image_speed * (50 / game_get_speed(gamespeed_fps));
		tile_image_index %= 3;
		for (var i = 1; i <= 3; i++) {
			layer_set_visible("Decoration_" + string(i), false);
			layer_set_visible("Tiling_" + string(i), false);
			layer_set_visible("Structure_" + string(i), false);
		}
		var index = floor(tile_image_index) + 1;
		layer_set_visible("Decoration_" + string(index), true);
		layer_set_visible("Tiling_" + string(index), true);
		layer_set_visible("Structure_" + string(index), true);
		break;
		
	case rBoardHyrule:
		if (global.board_light != prev_board_light) {
			var layers = [
				"Background",
				"Structure",
				"House",
				"Road",
				"Direction",
				"Misc"
			];
	
			for (var i = 0; i < array_length(layers); i++) {
				layer_set_visible(layers[i] + "_Light", global.board_light);
				layer_set_visible(layers[i] + "_Dark", !global.board_light);
			}
	
			prev_board_light = global.board_light;
		}
		break;
		
	case rBoardFASF:
		with (objBoardFASFBGManipulation) {
			apply_color_fx();
		}
		break;
}