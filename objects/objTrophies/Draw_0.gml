draw_sprite_ext(sprPartyLightReflector, 0, 400, 200, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_add);
draw_sprite_ext(sprPartyLight, 0, 400, 200, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_normal);

for (var i = -2; i <= 2; i++) {
	var s_x = trophy_x + 200 * i;
	var s_y = 520;
	var location = (trophy_selected + array_length(global.trophies) + i) % array_length(global.trophies);
	var trophy = global.trophies[location];
	draw_trophy(s_x, s_y, trophy, location);
}