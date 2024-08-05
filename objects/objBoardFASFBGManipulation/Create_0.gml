/// @desc


space_sprite = sprBkgBoardFASFSpace;
bg_width = sprite_get_width(space_sprite);
bg_height = sprite_get_height(space_sprite);


// Make background layer invisible
layer_space = layer_background_get_id(layer_get_id("BgSpace"));
layer_background_visible(layer_space, false);

// Background layer drawer
layer_space_drawer = layer_get_id("SpaceBackground");

fx = layer_get_fx(layer_space_drawer);
fx_parameter = fx_get_parameter(fx, "Intensity");


apply_red_color_fx = function() {
	//layer_set_fx(layer_space_drawer, 1.0);
	fx_set_parameter(fx, fx_parameter, 1.0);
}

/*
