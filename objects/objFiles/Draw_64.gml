for (var i = 0; i < array_length(file_sprites); i++) {
	if (file_opened != -1) {
		if (i == file_opened) {
			file_pos[i][0] = lerp(file_pos[i][0], 400 - file_width / 2, 0.2);
			
			if (menu_type < 3) {
				file_pos[i][1] = lerp(file_pos[i][1], file_original_pos[i][1] - 64, 0.2);
			} else {
				file_pos[i][1] = lerp(file_pos[i][1], -400, 0.2);
			}
		} else {
			file_pos[i][1] = lerp(file_pos[i][1], -400, 0.2);
		}
	} else {
		file_pos[i][0] = lerp(file_pos[i][0], file_original_pos[i][0], 0.2);
		file_pos[i][1] = lerp(file_pos[i][1], file_original_pos[i][1], 0.2);
	}
	
	var file_x = file_pos[i][0];
	var file_y = file_pos[i][1];
	
	var highlight = file_highlights[i];
	draw_sprite_ext(file_sprites[i], 0, file_x + file_width / 2, file_y + file_width / 2, highlight, highlight, 0, c_white, highlight - files_alpha);
}

for (var i = 0; i < array_length(menu_buttons); i++) {
	for (var j = 0; j < array_length(menu_buttons[i]); j++) {
		var button = menu_buttons[i][j];
		
		if (button == null) {
			continue;
		}
		
		button.check((file_opened != -1 && menu_type == i), menu_selected[menu_type] == j);
		button.draw(files_alpha);
	}
}

if (menu_type == 3) {
	for (var i = 0; i < array_length(online_texts); i++) {
		var button = menu_buttons[menu_type][i + 5];
		draw_set_font(fntFilesFile);
		draw_set_color(c_white);
		draw_set_valign(fa_middle);
		var text = online_texts[i];
		text = string_copy(text, 1, 18);
		
		if (string_length(online_texts[i]) > 18) {
			text += " ...";
		}
		
		var text_x = button.pos[0] - button.w / 2 + 10;
		draw_text_outline(text_x, button.pos[1], text, c_black);
		draw_set_valign(fa_top);
	}
}

draw_set_alpha(1);
