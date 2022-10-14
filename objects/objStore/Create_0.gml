fade_alpha = 1;
fade_start = true;
back = false;
surf = noone;
timer = 0;
dir = 1;

function Stock(index, price, has, buy, item, info) constructor {
	self.index = index;
	self.price = price;
	self.has = method(self, has);
	self.buy = method(self, buy);
	self.item = method(self, item);
	self.info = method(self, info);
}

store_stock = [[], [], [], []];

for (var i = 0; i < sprite_get_number(sprPartyBoardPictures); i++) {
	array_push(store_stock[0], new Stock(i, global.board_price, function() { return true; }, function() {}, function() {}, function() {}));
}

for (var i = 0; i < array_length(global.skins); i++) {
	var skin = global.skins[i];
	array_push(store_stock[2], new Stock(i, skin.price, function() {
		return have_skin(self.index);	
	}, function() {
		change_collected_coins(-self.price);
		gain_skin(self.index);
		save_file();
	}, function(x, y, moving) {
		var skin = get_skin(self.index);
		var sprite = skin[$ ((moving) ? "Idle" : "Run")];
		draw_sprite_ext(sprite, objStore.timer * sprite_get_speed(sprite) / game_get_speed(gamespeed_fps), x, y, 2 * objStore.dir, 2, 0, c_white, 1);
	}, function(x, y) {
		var skin = global.skins[self.index];
		draw_sprite_stretched(sprFangameMark, 1, x + 72, 60, 200, 152);
		gpu_set_colorwriteenable(true, true, true, false);
		draw_sprite_stretched(sprSkinsFangames, skin.fangame_index, x + 72, 60, 200, 152);
		gpu_set_colorwriteenable(true, true, true, true);
		draw_sprite_stretched(sprFangameMark, 0, x + 72, 60, 200, 152);
		draw_set_font(fntFilesButtons);
		draw_set_halign(fa_center);
		draw_text_color_outline(x + objStore.draw_w / 2, 10, skin.name, c_red, c_red, c_fuchsia, c_fuchsia, 1, c_black);
		draw_set_font(fntFilesData);
		draw_set_color(c_white);
		draw_text_outline(x + objStore.draw_w / 2, 220, skin.fangame_name, c_black);
		draw_set_halign(fa_left);
		draw_text_outline(x + 20, 260, "Maker: " + skin.maker, c_black);
	}));
}

store_row = 2;
store_selected = array_create(array_length(store_stock), 0);
store_target_selected = array_create(array_length(store_stock), 0);
store_x = 400;
store_target_x = 400;

held_time = 0;
controls_text = new Text(fntDialogue);

draw_x = 224;
draw_y = 32;
draw_w = 32 * 11;
draw_h = 32 * 13 - 112;