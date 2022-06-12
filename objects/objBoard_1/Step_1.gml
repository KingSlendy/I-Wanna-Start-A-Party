//Baba Is Board
if (room == rBoardBabaIsBoard) {
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
}
