if (roulette_alpha > 0) {
	var minigames_x = display_get_gui_width() / 2;
	var minigames_y = display_get_gui_height() / 2 - 50;
	var minigames_width = 300;
	var minigames_height = 40;
	
	draw_set_alpha(roulette_alpha);
	var priority = ds_priority_create();

	for (var i = 0; i < array_length(minigames); i++) {
		var minigame = minigames[i];
		var angle = roulette_angle + roulette_separation * i;
		ds_priority_add(priority, { minigame, angle }, lengthdir_y(1, angle));
	}

	var size = ds_priority_size(priority);
	var minigame = null;

	for (var i = 0; i < size; i++) {
		var current = ds_priority_delete_min(priority);
		minigame = current.minigame;
		var angle = current.angle;
	
		if (i == size - 1 && minigame.title != minigame_previous) {
			if (minigame.title == minigame_chosen.title && --roulette_max_laps <= 0) {
				choosed_minigame();
			} else if (!minigame_first) {
				audio_play_sound(sndRouletteRoll, 0, false);
			}
			
			minigame_previous = minigame.title;
			minigame_first = false;
		}
	
		var portrait = (minigame_seen(minigame.title)) ? minigame.portrait : minigame.hidden;
		var scale = remap(lengthdir_y(1, angle), -1, 1, 0.5, 1);
		var blend = (i != size - 1) ? c_gray : c_white;
		draw_sprite_ext(portrait, 0, minigames_x + lengthdir_x(300, angle) * roulette_spread, minigames_y + lengthdir_y(50, angle) * roulette_spread, scale, scale, 0, blend, draw_get_alpha());
	}

	ds_priority_destroy(priority);
	
	var box_x = minigames_x - minigames_width / 2;
	var box_y = minigames_y + 170;
	draw_box(box_x, box_y, minigames_width, minigames_height, c_dkgray, c_orange);
	var title = minigame.title;
	var label = minigame.label;
	draw_set_halign(fa_center);
	draw_text_info(box_x + minigames_width / 2, box_y + 7, (minigame_seen(title)) ? label : "?????????", minigames_width - 20);
	draw_set_halign(fa_left);
	//var text = new Text(global.fntDialogue, (minigame_seen(title)) ? label : "?????????");
	//text.draw(box_x + 15, box_y + 7);
}