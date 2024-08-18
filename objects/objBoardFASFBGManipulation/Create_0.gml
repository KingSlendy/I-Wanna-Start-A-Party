/// @desc


space_sprite = sprBkgBoardFASFSpace;
bg_width = sprite_get_width(space_sprite);
bg_height = sprite_get_height(space_sprite);


// Make background layer invisible
layer_space = layer_background_get_id(layer_get_id("BgSpace"));
layer_background_visible(layer_space, false);

// Background layer drawer
layer_space_drawer = layer_get_id("SpaceBackground");

fx = layer_get_fx("RedFilterBackground");
fx_parameter = fx_get_parameter(fx, "g_Intensity");

fx_set_parameter(fx, "g_Intensity", 0.0);
//red_tint = false;

function apply_red_color_fx() {
	//layer_set_fx(layer_space_drawer, 1.0);
	fx_set_parameter(fx, "g_Intensity", 1.0);
	print("FX: Did it work?");
}


tile_layer_FASF = layer_get_id("FASFTiles");
//tilemap_layer_FASF = layer_tilemap_get_id(tile_layer_FASF);

tile_layer_FASF_glass = layer_get_id("FASFTilesGlass");
//tilemap_layer_FASF_glass = layer_tilemap_get_id(tile_layer_FASF_glass);

layer_x(tile_layer_FASF, (8)*32);
layer_x(tile_layer_FASF_glass, (8)*32);
//layer_y(tile_layer_FASF, (13-5)*32);

/*
