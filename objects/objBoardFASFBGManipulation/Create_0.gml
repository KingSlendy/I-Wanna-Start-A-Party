space_sprite = sprBkgBoardFASFSpace;
bg_width = sprite_get_width(space_sprite);
bg_height = sprite_get_height(space_sprite);

// Make background layer invisible
layer_space = layer_background_get_id(layer_get_id("BgSpace"));
layer_background_visible(layer_space, false);

// Background layer drawer
layer_space_drawer = layer_get_id("SpaceBackground");

fx = layer_get_fx("ColorFilterBackground");
fx_set_parameter(fx, "g_Intensity", 0.0);
last_space_mode = null;

function apply_color_fx() {
	if (global.board_fasf_space_mode == last_space_mode) {
		//return;
	}
	
	var color = [0.0, 0.0, 0.0];
	var intensity = 1.0;
	
	switch (global.board_fasf_space_mode) {
		case FASF_SPACE_MODES.NOTHING: intensity = 0.0; break; //No filter
		case FASF_SPACE_MODES.ICE: color = [0.0, 1.0, 1.0]; break; //Cyan filter
		case FASF_SPACE_MODES.MUD: color = [0.3215686274509804, 0.192156862745098, 0.0]; break; //Brown filter
		case FASF_SPACE_MODES.PORTAL: color = [1.0, 0.0, 1.0]; break; //Purple filter
	}
	
	fx_set_parameter(fx, "g_Intensity", intensity);
	fx_set_parameter(fx, "g_TintCol", color);
	last_space_mode = global.board_fasf_space_mode;
}


tile_layer_FASF = layer_get_id("FASFTiles");
tile_layer_FASF_glass = layer_get_id("FASFTilesGlass");

layer_x(tile_layer_FASF, 8 * 32);
layer_x(tile_layer_FASF_glass, 8 * 32);