depth = layer_get_depth("Tiles") + 1;
next_seed_inline();
x += 32 * irandom(12);
var map_id = layer_tilemap_get_id("Tiles");
var tile = tilemap_get_at_pixel(map_id, x, y + 1);
tile = tile_set_empty(tile);
tilemap_set(map_id, tile, tilemap_get_cell_x_at_pixel(map_id, x, y + 1), tilemap_get_cell_y_at_pixel(map_id, x, y + 1));

with (instance_place(x, y + 1, objMinigame4vs_Golf_Block)) {
	instance_destroy();
}

instance_create_layer(x + 1, y, layer, objMinigame4vs_Golf_MicroBlock);
instance_create_layer(x + 32 - 4, y, layer, objMinigame4vs_Golf_MicroBlock);
instance_create_layer(x, y, layer, objMinigame4vs_Golf_Hole);

x -= 12;
y += 6;