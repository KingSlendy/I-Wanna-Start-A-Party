draw_sprite_ext(sprPartyLightReflector, 0, 400, 200, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_add);
draw_sprite_ext(sprPartyLight, 0, 400, 200, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_normal);

for (var i = -2; i <= 2; i++) {
	var s_x = trophy_x + 200 * i;
	var s_y = 520;
	var location = (trophy_selected + array_length(global.trophies) + i) % array_length(global.trophies);
	var trophy = global.trophies[location];
	draw_sprite(sprModesTrophies, (have_trophy(location)) ? trophy.rank : 3, s_x, s_y);
	draw_sprite(sprTrophyImages, (have_trophy(location)) ? trophy.image : 0, s_x, s_y - 125);
	draw_set_font(fntFilesData);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_text_outline(s_x, s_y - 40, string(location + 1), c_black);
	draw_set_halign(fa_left);
	
	//if (!have_skin(location)) {
	//	draw_sprite(sprCoin, 0, s_x - 30, s_y + 40);
	//	var skin = global.skins[location];
	//	draw_set_font(fntPlayerInfo);
	//	draw_set_color((skin.shop_price <= global.collected_coins) ? c_white : c_red);
	//	draw_set_valign(fa_middle);
	//	draw_text_outline(s_x - 10, s_y + 40, string(skin.shop_price), c_black);
	//	draw_set_valign(fa_top);
	//}
}
