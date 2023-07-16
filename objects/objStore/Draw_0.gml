draw_sprite_ext(sprPartyLightReflector, 0, 400, 200, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_add);
draw_sprite_ext(sprPartyLight, 0, 400, 200, 1, 1, 0, c_white, 1);
gpu_set_blendmode(bm_normal);
draw_set_alpha(store_alpha);

for (var i = -3; i <= 3; i++) {
	var sx = store_x + 150 * i;
	var sy = 500;
	var row = store_stock[store_row];
	var location = (store_selected[store_row] + array_length(row) + i) % array_length(row);
	var stock = row[location];
	stock.item(sx, sy, (store_selected[store_row] == store_target_selected[store_row]));
	
	if (!stock.has()) {
		draw_sprite(sprCoin, 0, sx - 30, sy + 40);
		language_set_font(global.fntPlayerInfo);
		draw_set_color((stock.price <= global.collected_coins) ? c_white : c_red);
		draw_set_valign(fa_middle);
		draw_text_outline(sx - 10, sy + 40, string(stock.price), c_black);
		draw_set_valign(fa_top);
	}
}

draw_set_alpha(1);