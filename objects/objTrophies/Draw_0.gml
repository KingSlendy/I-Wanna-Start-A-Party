draw_sprite_ext(sprPartyLightReflector, 0, 400, 200, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_add);
draw_sprite_ext(sprPartyLight, 0, 400, 200, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_normal);

for (var i = -2; i <= 2; i++) {
	var s_x = trophy_x + 200 * i;
	var s_y = 520;
	var location = (trophy_selected + array_length(global.trophies) + i) % array_length(global.trophies);
	var trophy = global.trophies[location];
	draw_sprite(sprModesTrophies, (achieved_trophy(location)) ? trophy.rank : TrophyRank.Unknown, s_x, s_y);
	draw_sprite(sprTrophyImages, (achieved_trophy(location)) ? trophy.image : 0, s_x, s_y - 125);
	draw_set_font(fntFilesData);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_text_outline(s_x, s_y - 40, string(location + 1), c_black);
	draw_set_halign(fa_left);
}