draw_sprite_ext(sprPartyLightReflector, 0, 400, 200, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_add);
draw_sprite_ext(sprPartyLight, 0, 400, 200, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_normal);

for (var i = -2; i <= 2; i++) {
	var s_x = skin_x + 150 * i;
	var s_y = 500;
	var location = (skin_selected + array_length(global.skins) + i) % array_length(global.skins);
	var skin = get_skin(location);
	var sprite = skin[$ ((skin_selected == skin_target_selected) ? "Idle" : "Run")];
	draw_sprite_ext(sprite, timer * sprite_get_speed(sprite) / game_get_speed(gamespeed_fps), s_x, s_y, 2 * dir, 2, 0, c_white, 1);
	
	if (!array_contains(global.collected_skins, location)) {
		draw_sprite(sprCoin, 0, s_x - 30, s_y + 40);
		var skin = global.skins[location];
		draw_set_font(fntPlayerInfo);
		draw_set_color((skin.price <= global.collected_coins) ? c_white : c_red);
		draw_set_valign(fa_middle);
		draw_text_outline(s_x - 10, s_y + 40, string(skin.price), c_black);
		draw_set_valign(fa_top);
	}
}
