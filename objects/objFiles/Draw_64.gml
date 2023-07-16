for (var i = 0; i < array_length(file_sprites); i++) {
	if (file_opened != -1) {
		if (i == file_opened) {
			file_pos[i][0] = lerp(file_pos[i][0], 400 - file_width / 2, 0.2);
			
			if (menu_type < 3 || menu_type == 6) {
				file_pos[i][1] = lerp(file_pos[i][1], file_original_pos[i][1] - 32, 0.2);
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

for (var i = 0; i < array_length(option_buttons); i++) {
	var button = option_buttons[i];
	button.check((file_opened == -1), option_selected == i);
	button.draw(files_alpha);
}

for (var i = 0; i < array_length(menu_buttons); i++) {
	for (var j = 0; j < array_length(menu_buttons[i]); j++) {
		var button = menu_buttons[i][j];
		
		if (button == null) {
			continue;
		}
		
		button.check((file_opened != -1 && menu_type == i), menu_selected[menu_type] == j);
		
		if (i == 5 && (j >= 0 && j < 5) && global.player_id != 1) {
			continue;
		}
		
		button.draw(files_alpha);
	}
}

language_set_font(global.fntFilesInfo);
draw_set_alpha(1 - files_alpha);
draw_set_halign(fa_center);
var button = menu_buttons[upper_type][0];
var target_map = remap(button.pos[0], button.original_pos[0], button.target_pos[0], 0, 1);
draw_text_color_outline(400, -100 + 150 * target_map, upper_text, c_gold, c_gold, c_yellow, c_yellow, 1 - files_alpha, c_black);
draw_set_halign(fa_left);

if (array_contains([1, 3, 4, 5], menu_type)) {
	var texts;
	
	switch (menu_type) {
		case 1: texts = [file_name]; break;
		case 3: texts = online_texts; break;
		case 4: texts = lobby_texts; break;
		case 5: texts = player_texts; break;
	}

	language_set_font(global.fntFilesButtons);
	draw_set_valign(fa_middle);
	
	for (var i = 0; i < array_length(texts); i++) {
		if (menu_type == 5) {
			var player = focus_player_by_id(i + 1);
			
			if (player != null/* && player.online*/) {
				texts[i] = player.network_name;
				//texts[i] = string("{0}: {1} ({2}) [{3}]", player.network_name, player.network_id, player.online, (player.network_id == global.player_id) ? "Me" : "No");
			}
		}
		
		var button = menu_buttons[menu_type][i + (array_get_index(menu_buttons[menu_type], null) + 1)];
		var text = texts[i];
		text = string_copy(text, 1, 21);
		
		if (string_length(texts[i]) > 21) {
			text += " ...";
		}
		
		if (menu_type == 4 && i == 1) {
			text = string_repeat("*", string_length(text));
		}
		
		var text_x = button.pos[0] - button.w / 2 + 10;
		draw_set_color(c_white);
		
		if (menu_type == 5 && i == 0) {
			draw_set_color(c_yellow);
		}
		
		draw_text_outline(text_x, button.pos[1], text, c_black);
		draw_set_color(c_white);
	}
	
	draw_set_valign(fa_top);
	
	if (IS_ONLINE && online_reading) {
		draw_sprite(sprFilesLoading, current_time / 60, 330, 412 - 80 * (menu_type == 5));
	}
}

var length = array_length(lobby_list);

for (var i = 0; i < length; i++) {
	var lobby = lobby_list[i];
	lobby.check((menu_type == 4), (lobby_seeing && lobby_selected == i));
	
	if (menu_type == 4) {
		lobby.target_pos[1] = lobby.main_pos[1] - 60 * lobby_selected
	} else {
		lobby.target_pos = [lobby.original_pos[0], lobby.original_pos[1]];
	}
	
	lobby.draw(files_alpha);
}

draw_set_alpha(1);

controls_text.set(draw_action_small(global.actions.jump) + " " + language_get_text("WORD_GENERIC_MENU_ACCEPT") + "   " + draw_action_small(global.actions.left) + draw_action_small(global.actions.up) + draw_action_small(global.actions.down) + draw_action_small(global.actions.right) + " " + language_get_text("WORD_GENERIC_MENU_MOVE") + "    " + draw_action_small(global.actions.shoot) + " " + language_get_text("WORD_GENERIC_MENU_CANCEL"));
controls_text.draw(420, 580);