timer++;
timer %= 1000;

if (fade_start) {
	if (!back) {
		if (get_player_count(objPlayerBase) == global.player_max) {
			fade_alpha -= 0.03 * DELTA;
			music_play(bgmStore);
		
			if (fade_alpha <= 0) {
				fade_alpha = 0;
				fade_start = false;
			}
		}
	} else {
		fade_alpha += 0.03 * DELTA;
		
		if (fade_alpha >= 1) {
			fade_alpha = 1;
			fade_start = false;
			room_goto(rModes);
			exit;
		}
	}
}

if (store_move_row != 0) {
	store_alpha = lerp(store_alpha, store_target_alpha, 0.3);
	
	if (point_distance(store_alpha, 0, store_target_alpha, 0) < 0.01) {
		if (store_target_alpha == 0) {
			store_row = (store_row + array_length(store_stock) + store_move_row) % array_length(store_stock);
			store_target_alpha = 1;
		} else {
			store_alpha = 1;
			store_move_row = 0;
		}
	}
	
	exit;
}

if (store_selected[store_row] != store_target_selected[store_row]) {
	store_x = lerp(store_x, store_target_x, (held_time == 25) ? 0.6 : 0.4);
	
	if (point_distance(store_x, 0, store_target_x, 0) < 1.5) {
		store_x = 400;
		store_target_x = store_x;
		store_selected[store_row] = store_target_selected[store_row];
	}
}

if (!fade_start && store_selected[store_row] == store_target_selected[store_row]) {
	var held_h = (global.actions.right.held() - global.actions.left.held());
	
	if (held_h != 0) {
		held_time = min(++held_time, 25);
	} else {
		held_time = 0;
	}
	
	var scroll_h = (global.actions.right.pressed() - global.actions.left.pressed());
	
	if (held_h == 0) {
		held_h = scroll_h;	
	}
	
	if ((held_h != 0 && held_time == 25) || scroll_h != 0) {
		var row = store_stock[store_row];
		store_target_x -= 150 * held_h;
		store_target_selected[store_row] = (store_selected[store_row] + array_length(row) + held_h) % array_length(row);
		dir = held_h * -1;
		audio_play_sound(global.sound_cursor_move, 0, false);
		exit;
	}
	
	var scroll_v = (global.actions.down.pressed() - global.actions.up.pressed());
	
	if (scroll_v != 0) {
		store_move_row = scroll_v;
		store_target_alpha = 0;
		audio_play_sound(global.sound_cursor_move, 0, false);
		exit;
	}
	
	if (global.actions.jump.pressed()) {
		var row = store_stock[store_row];
		var stock = row[store_selected[store_row]];
		
		if (!stock.has() && stock.price <= global.collected_coins) {
			change_collected_coins(-stock.price);
			stock.buy()
			audio_play_sound(global.sound_cursor_select2, 0, false);
			exit;
		}
	}
	
	if (global.actions.shoot.pressed()) {
		back = true;
		fade_start = true;
		music_fade();
		audio_play_sound(global.sound_cursor_back, 0, false);
		exit;
	}
	
	if (global.actions.misc.pressed()) {
		/*
			0: Release
			1: Price (ascending)
			2: Price (descending)
			3: Name
		*/

		store_sort[store_row] = (store_sort[store_row] + 4 + 1) % 4;
		var row = store_stock[store_row];

		switch (store_sort[store_row]) {
			case 0:
				array_sort(row, function(a, b) { return (a.index - b.index); });
				break;
				
			case 1:
				array_sort(row, function(a, b) {
					var price_a = (a.has()) ? 0 : a.price;
					var price_b = (b.has()) ? 0 : b.price;
					
					if (price_a == price_b) {
						return (a.index - b.index);
					}
					
					return (price_a - price_b);
				});
				break;
				
			case 2:
				array_sort(row, function(a, b) {
					var price_a = (a.has()) ? 0 : a.price;
					var price_b = (b.has()) ? 0 : b.price;
					
					if (price_a == price_b) {
						return (a.index - b.index);
					}
					
					return (price_b - price_a);
				});
				break;
				
			case 3:
				array_sort(row, function(a, b) {
					var name_a = a.element().name;
					var name_b = b.element().name;
					
					if (name_a == name_b) {
						return 0;
					}
					
					return (name_a < name_b) ? -1 : 1;
				});
				break;
		}
		
		audio_play_sound(global.sound_cursor_select, 0, false);
	}
}