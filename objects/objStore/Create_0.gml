fade_alpha = 1;
fade_start = true;
back = false;
surf = noone;
timer = 0;
dir = 1;

function Stock(index, price, has, buy, element, item, info) constructor {
	self.index = index;
	self.price = price;
	self.has = method(self, has);
	self.buy = method(self, buy);
	self.element = method(self, element);
	self.item = method(self, item);
	self.info = method(self, info);
}

store_stock = [[], [], [], [], []];

for (var i = 0; i < array_length(global.boards); i++) {
	array_push(store_stock[0], new Stock(i, global.board_price, function() {
		return board_collected(self.index);
	}, function() {
		board_collect(self.index);
	}, function() {
		return global.boards[self.index];
	}, function(x, y, _) {
		var logo = (self.has()) ? self.index + 1 : 0;
		draw_sprite_ext(sprPartyBoardLogos, logo, x, y, 0.4, 0.4, 0, c_white, objStore.store_alpha);
	}, function(x, y) {
		var board = self.element();
		var name = (self.has()) ? board.name : "?????????";
		var picture = (self.has()) ? self.index + 1 : 0;
		draw_sprite_stretched(sprFangameMark, 1, x + 72, 60, 200, 152);
		gpu_set_colorwriteenable(true, true, true, false);
		draw_sprite_stretched(sprPartyBoardPictures, picture, x + 72, 60, 200, 152);
		gpu_set_colorwriteenable(true, true, true, true);
		draw_sprite_stretched(sprFangameMark, 0, x + 72, 60, 200, 152);
		language_set_font(global.fntFilesButtons);
		draw_set_halign(fa_center);
		draw_text_info(x + objStore.draw_w / 2, 10, name, objStore.draw_w - 8, c_red, c_red, c_fuchsia, c_fuchsia);
		language_set_font(global.fntFilesData);
		draw_set_halign(fa_left);
		draw_text_info(x + 20, 230, language_get_text("STORE_MAKER") + ": " + board.makers, objStore.draw_w - 8);
	}));
}

var types = minigame_types();
var index = 0;

for (var i = 0; i < array_length(types); i++) {
	var minigames = global.minigames[$ types[i]];
	
	for (var j = 0; j < array_length(minigames); j++) {
		var minigame = minigames[j];
		
		var stock = new Stock(index++, global.minigame_price, function() {
			return minigame_seen(self.minigame.title);
		}, function() {
			minigame_unlock(self.minigame.title);
		}, function() {
			return self.minigame;
		}, function(x, y, _) {
			var seen_minigame = self.has();
			var portrait = (seen_minigame) ? self.minigame.portrait : self.minigame.hidden;
			language_set_font(global.fntPlayerInfo);
			draw_set_halign(fa_center);
			draw_sprite_ext(portrait, 0, x, y - 30, 0.5, 0.5, 0, c_white, objStore.store_alpha);
			draw_set_halign(fa_left);
		}, function(x, y) {
			var seen_minigame = self.has();
			var label = (seen_minigame) ? self.minigame.label : "?????????";
			var preview = (seen_minigame) ? self.minigame.preview : 0;
			var fangame_name = (seen_minigame) ? self.minigame.fangame_name : "???";
			draw_sprite_stretched(sprFangameMark, 1, x + 72, 60, 200, 152);
			gpu_set_colorwriteenable(true, true, true, false);
			draw_sprite_stretched(sprMinigamesFangames, preview, x + 72, 60, 200, 152);
			gpu_set_colorwriteenable(true, true, true, true);
			draw_sprite_stretched(sprFangameMark, 0, x + 72, 60, 200, 152);
			language_set_font(global.fntFilesButtons);
			draw_set_halign(fa_center);
			draw_text_info(x + objStore.draw_w / 2, 10, label, objStore.draw_w - 8, c_red, c_red, c_fuchsia, c_fuchsia);
			language_set_font(global.fntFilesData);
			draw_text_info(x + objStore.draw_w / 2, 220, fangame_name, objStore.draw_w - 8);
		});
		
		stock.minigame = minigame;
		array_push(store_stock[1], stock);
	}
}

for (var i = 0; i < array_length(global.trials); i++) {
	array_push(store_stock[2], new Stock(i, global.trial_price, function() {
		return trial_collected(self.index);
	}, function() {
		trial_collect(self.index);
	}, function() {
		return global.trials[self.index];
	}, function(x, y, _) {
		draw_sprite_ext(sprModesTrials, 0, x, y, 0.2, 0.2, 0, c_white, objStore.store_alpha);
		language_set_font(global.fntFilesData);
		draw_text_color_outline(x + 8, y + 8, "#" + string(self.index + 1), c_red, c_red, c_yellow, c_yellow, objStore.store_alpha, c_black);
	}, function(x, y) {
		var trial = self.element();
		language_set_font(global.fntFilesButtons);
		draw_set_halign(fa_center);
		draw_text_info(x + objStore.draw_w / 2, 10, trial.label, objStore.draw_w - 8, c_red, c_red, c_fuchsia, c_fuchsia);
		draw_sprite_ext(sprModesTrials, 0, x + objStore.draw_w / 2, y + objStore.draw_h / 2 - 20, 0.5, 0.5, 0, c_white, 1);
		language_set_font(global.fntFilesData);
		draw_set_halign(fa_left);
		draw_text_info(x + 10, 220, language_get_text("STORE_MINIGAMES") + ": " + string(array_length(trial.minigames)), objStore.draw_w - 8);
		objStore.rewards_text.set($"{language_get_text("WORD_GENERIC_REWARD")}: {draw_coins_price(trial.reward)}");
		objStore.rewards_text.draw(x + 10, 250);
	}));
}

for (var i = 0; i < array_length(global.skins); i++) {
	var skin = global.skins[i];
	array_push(store_stock[3], new Stock(i, skin.price, function() {
		return have_skin(self.index);
	}, function() {
		gain_skin(self.index);
	}, function() {
		return global.skins[self.index];
	}, function(x, y, moving) {
		var skin = get_skin(self.index);
		var sprite = skin[$ ((moving) ? "Idle" : "Run")];
		draw_sprite_ext(sprite, objStore.timer * sprite_get_speed(sprite) / game_get_speed(gamespeed_fps), x, y, 2 * objStore.dir, 2, 0, c_white, objStore.store_alpha);
	}, function(x, y) {
		var skin = self.element();
		draw_sprite_stretched(sprFangameMark, 1, x + 72, 60, 200, 152);
		gpu_set_colorwriteenable(true, true, true, false);
		draw_sprite_stretched(sprSkinsFangames, skin.fangame_index, x + 72, 60, 200, 152);
		gpu_set_colorwriteenable(true, true, true, true);
		draw_sprite_stretched(sprFangameMark, 0, x + 72, 60, 200, 152);
		language_set_font(global.fntFilesButtons);
		draw_set_halign(fa_center);
		draw_text_info(x + objStore.draw_w / 2, 10, skin.name, objStore.draw_w - 8, c_red, c_red, c_fuchsia, c_fuchsia);
		language_set_font(global.fntFilesData);
		draw_text_info(x + objStore.draw_w / 2, 220, skin.fangame_name, objStore.draw_w - 8);
		draw_set_halign(fa_left);
		draw_text_info(x + 20, 260, language_get_text("STORE_MAKER") + ": " + skin.maker, objStore.draw_w - 8);
	}));
}

for (var i = 0; i < array_length(global.reactions); i++) {
	var react = global.reactions[i];
	array_push(store_stock[4], new Stock(i, react.price, function() {
		return have_reaction(self.index);	
	}, function() {
		gain_reaction(self.index);
	}, function() {
		return global.reactions[self.index];
	}, function(x, y, _) {
		draw_sprite_ext(sprReactions, self.index, x, y - 10, 0.25, 0.25, 0, c_white, objStore.store_alpha);
	}, function(x, y) {
		var react = self.element();
		draw_sprite_ext(sprReactions, react.index, x + objStore.draw_w / 2, 160, 0.75, 0.75, 0, c_white, 1);
		language_set_font(global.fntFilesButtons);
		draw_set_halign(fa_center);
		draw_text_info(x + objStore.draw_w / 2, 10, react.name, objStore.draw_w - 8, c_red, c_red, c_fuchsia, c_fuchsia);
		language_set_font(global.fntFilesData);
		draw_set_halign(fa_left);
		draw_text_info(x + 20, 260, language_get_text("STORE_MAKER") + ": " + react.maker, objStore.draw_w - 8);
	}));
}

store_sort = array_create(array_length(store_stock), 0);

store_alpha = 1;
store_target_alpha = store_alpha;
store_row = 0;
store_move_row = 0;
store_selected = array_create(array_length(store_stock), 0);
store_target_selected = array_create(array_length(store_stock), 0);
store_x = 400;
store_target_x = 400;

held_time = 0;
controls_text = new Text(global.fntDialogue);
rewards_text = new Text(global.fntFilesData);

draw_x = 224;
draw_y = 32;
draw_w = 32 * 11;
draw_h = 32 * 13 - 112;