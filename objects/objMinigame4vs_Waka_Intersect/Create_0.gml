image_xscale = 3;
var map_id = layer_tilemap_get_id("Lines");

for (var i = -1; i < 4; i++) {
	var tile = 30;
	
	if (i == -1) {
		tile = 29;
	} else if (i == 3) {
		tile = 31;
	}
	
	var tile_x = x + 32 * i + 16;
	var tile_y = y + 16;
	tilemap_set(map_id, tile, tilemap_get_cell_x_at_pixel(map_id, tile_x, tile_y), tilemap_get_cell_y_at_pixel(map_id, tile_x, tile_y));
}