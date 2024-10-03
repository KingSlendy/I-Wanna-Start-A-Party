gpu_set_blendmode(bm_add);
gpu_set_tex_filter(true);

var wave_light_alpha = moon_wave(0.7, 1, 4, 0);
var wave_light_scale = moon_wave(0, 5, 2, 0);

//repeat 2
draw_sprite_ext(
	sprMinigame2vs2_Castle_MoonLight, 0,
	64 + 128, 64 + 128,
	image_xscale * 11, image_yscale * 11, 0, c_yellow, wave_light_alpha
);
		
draw_sprite_ext(
	sprMinigame2vs2_Castle_MoonLight, 0,
	64 + 128, 64 + 128,
	image_xscale * 13 + wave_light_scale, image_yscale * 13 + wave_light_scale, 0, c_aqua, 0.2
);
		
draw_sprite_general(
	sprite_index, 0, 0, 0, sprite_width, sprite_height,
	64, 64,
	image_xscale, image_yscale, 0, c_black, c_white, c_white, c_white, wave_light_alpha
);
		
gpu_set_blendmode(bm_normal);
gpu_set_tex_filter(false);