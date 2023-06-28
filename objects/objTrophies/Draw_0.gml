draw_sprite_ext(sprPartyLightReflector, 0, 400, 200, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_add);
draw_sprite_ext(sprPartyLight, 0, 400, 200, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_normal);

for (var i = -2; i <= 2; i++) {
	var sx = trophy_x + 200 * i;
	var sy = 520;
	var location = (trophy_selected + array_length(global.trophies) + i) % array_length(global.trophies);
	var trophy = global.trophies[location];
	draw_trophy(sx, sy, trophy);
	var price = 0;
	
	switch (trophy.state()) {
		case TrophyState.Unknown: price = global.trophy_hint_price; break;
		case TrophyState.Hint: price = global.trophy_spoiler_price; break;
	}

	if (price != 0) {
		draw_sprite(sprCoin, 0, sx - 30, sy + 20);
		language_set_font(fntPlayerInfo);
		draw_set_color((price <= global.collected_coins) ? c_white : c_red);
		draw_set_valign(fa_middle);
		draw_text_outline(sx - 10, sy + 20, string(price), c_black);
		draw_set_valign(fa_top);
	}
}