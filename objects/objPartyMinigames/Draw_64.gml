draw_set_font(fntPlayerInfo);
draw_set_color(c_white);

for (var i = 0; i < global.player_max; i++) {
	var player = focus_player_by_id(i + 1);
	var box_w = 110;
	var box_h = 32;
	var box_x = player.x - box_w / 2;
	var box_y = display_get_gui_height() - box_h;
	draw_box(box_x, box_y, box_w, box_h, player_color_by_turn(i + 1), c_white, 0.8,, 1);
	draw_player_name(box_x + 20, box_y + box_h / 2 + 2, i + 1);
}

var draw_x = 160;
var draw_y = 32;
var draw_w = 32 * 15;
var draw_h = 32 * 15 - 112;

if (!surface_exists(surf)) {
	surf = surface_create(472, 472 - 112);
}

surface_set_target(surf);
draw_clear_alpha(c_black, 0);
menu_x = lerp(menu_x, -menu_sep * menu_page, 0.3);

//Save present
var save_x = menu_x - menu_sep;
var save_y = 0;

if (save_present) {
	for (var i = 1; i <= global.player_max; i++) {
		var player_info = focus_info_by_turn(i);
	
		with (player_info) {
			target_draw_x = save_x;
			self.draw_x = save_x;
			event_perform(ev_draw, ev_gui);
		}
	}
	
	draw_sprite_stretched(save_sprite, 0, save_x + 270, save_y + 20, board_w * 0.5, board_h * 0.5);
	draw_set_font(fntPlayerInfo);
	draw_text_outline(save_x + 290, save_y + 140, string_interp("Turn: {0}/{1}", save_turn, save_max_turns), c_black);
	draw_text_outline(save_x + 290, save_y + 170, string_interp("Bonus: {0}", (save_give_bonus_shines) ? "ON" : "OFF"), c_black);
	var text = new Text(fntDialogue);

	for (var i = 0; i < 2; i++) {
		var option_x = save_x + 290;
		var option_y = save_y + 270 + 45 * i;
		draw_box(option_x, option_y, 130, 40, (i == save_selected) ? c_ltgray : c_dkgray, c_white,,, 1);
		text.set(draw_option_afford((i == 0) ? "Resume" : "Decline", true, (i == save_selected)));
		text.draw(option_x + 15, option_y + 6); 
	}
}

//Skin selection
var length = array_length(skins);

for (var r = -2; r <= 2; r++) {
	var now_r = (skin_row + length + r) % length;
	var skin_c = skins[now_r];
	
	for (var c = 0; c < array_length(skin_c); c++) {
		var is_selected = (now_r == skin_target_row && c == skin_col);
		var skin = skin_c[c];
		var color = (is_selected) ? player_color_by_turn(skin_player + 1) : c_white;
		var already_selected = (array_contains(skin_selected, skin));
		var box_x = menu_x + skin_w * c;
		var box_y = skin_y + skin_h * r;
		draw_set_alpha(remap(point_distance(box_y, 0, skin_h, 0), 0, skin_h, 1, 0.75));
		draw_box(box_x, box_y, skin_w, skin_h, c_dkgray, color);
		
		if (!is_selected && already_selected) {
			gpu_set_blendmode(bm_add);
			draw_box(box_x, box_y, skin_w, skin_h, c_white, color, 0);
			gpu_set_blendmode(bm_normal);
		}
		
		if (have_skin(skin)) {
			var skin_sprite = get_skin(skin)[$ "Idle"];
		} else {
			var skin_sprite = (skin != noone) ? sprPlayerIdle : sprPlayerRandom;
		}
		
		draw_sprite_ext(skin_sprite, 0, box_x + skin_w / 2 + 3, box_y + skin_h / 2 + 6, 3, 3, 0, (!already_selected) ? c_white : c_gray, draw_get_alpha());
		draw_set_alpha(1);
	}
}

var key_x = menu_x + skin_w * skin_col;
var key_y = skin_y + skin_h * sign(skin_y - skin_target_y);
draw_sprite_ext(bind_to_key(global.actions.right.button), 0, key_x + 120, key_y + 60, 0.3, 0.3, 0, c_white, 1);
draw_sprite_ext(bind_to_key(global.actions.up.button), 0, key_x + skin_w / 2, key_y, 0.3, 0.3, 0, c_white, 1);
draw_sprite_ext(bind_to_key(global.actions.left.button), 0, key_x, key_y + 60, 0.3, 0.3, 0, c_white, 1);
draw_sprite_ext(bind_to_key(global.actions.down.button), 0, key_x + skin_w / 2, key_y + skin_h, 0.3, 0.3, 0, c_white, 1);

if (room == rParty) {
	//Board selection
	var box_x = menu_x + menu_sep;
	var box_y = 0;
	draw_sprite_stretched(sprPartyBoardMark, 1, box_x + 60, box_y + 32, board_w, board_h);
	gpu_set_colorwriteenable(true, true, true, false);
	var length = sprite_get_number(sprPartyBoardPictures);

	for (var i = -1; i <= 1; i++) {
		draw_sprite_stretched(sprPartyBoardPictures, (board_selected + length + i) % length, box_x + 104 + 264 * i + board_x, box_y + 47, board_img_w, board_img_h);
	}

	gpu_set_colorwriteenable(true, true, true, true);
	draw_sprite_stretched(sprPartyBoardMark, 0, box_x + 60, box_y + 32, board_w, board_h);
	
	var text = new Text(fntFilesButtons);
	text.set("Turns: " + ((board_options_selected == 1) ? "{WAVE}{RAINBOW}" : "") + string(global.max_board_turns));
	text.draw(box_x + 100, box_y + box_y + 32 + board_h + 10);
	text.set("Bonus: " + ((board_options_selected == 2) ? "{WAVE}{RAINBOW}" : "") + ((global.give_bonus_shines) ? "ON" : "OFF"));
	text.draw(box_x + 100, box_y + box_y + 32 + board_h + 10 + 40);
	var target_y, target_h;
	
	switch (board_options_selected) {
		case 0:
			target_y = box_y + 16;
			target_h = board_h + 32;
			break;
			
		case 1:
			target_y = box_y + 32 + board_h;
			target_h = 56;
			break;
			
		case 2:
			target_y = box_y + 32 + board_h + 40;
			target_h = 56;
			break;
	}
	
	board_options_y = lerp(board_options_y, target_y, 0.3);
	board_options_h = lerp(board_options_h, target_h, 0.3);
	draw_sprite_ext(bind_to_key(global.actions.left.button), 0, box_x + 16 + 24, board_options_y + board_options_h / 2, 0.5, 0.5, 0, c_white, 1);
	draw_sprite_ext(bind_to_key(global.actions.right.button), 0, box_x + 16 + board_options_w - 24, board_options_y + board_options_h / 2, 0.5, 0.5, 0, c_white, 1);
} else {
	var minigames_x = menu_x + menu_sep;
	var minigames_y = minigames_show_y + 350 * -minigames_row_selected;
	var names = minigame_types();
	var types = ["4 vs.", "1 vs. 3", "2 vs. 2"];
	
	for (var i = 0; i < array_length(names); i++) {
		var row_y = minigames_y + 10 + 350 * i;
		draw_set_font(fntFilesFile);
		draw_set_halign(fa_left);
		draw_text_color_outline(minigames_x + 10, row_y, types[i], c_red, c_red, c_yellow, c_yellow, 1, c_black);
		var portraits = minigames_portraits[$ names[i]];
		
		for (var j = -2; j <= 2; j++) {
			var row_x = minigames_show_x + 240 * j;
			var location = (minigames_col_selected + array_length(portraits) + j) % array_length(portraits);
			var portrait = portraits[location];
			var dist = remap(point_distance(row_x, minigames_show_y, 0, minigames_target_show_y), 0, 480, 1, 0.5);
			draw_sprite_ext(portrait, 0, minigames_x + draw_w / 2 + row_x, row_y + 150, dist, dist, 0, c_white, dist);
			draw_set_font(fntPlayerInfo);
			draw_set_halign(fa_center);
			var title = global.minigames[$ names[i]][location].title;
			draw_text_transformed_color_outline(minigames_x + draw_w / 2 + row_x, row_y + 250, (array_contains(global.seen_minigames, title)) ? title : "?????????", dist, dist, 0, c_red, c_red, c_fuchsia, c_fuchsia, dist, c_black);
			draw_set_halign(fa_left);
		}
	}
	
	if (minigames_row_selected > 0) {
		draw_sprite_ext(bind_to_key(global.actions.up.button), 0, minigames_x + draw_w / 2, 30, 0.5, 0.5, 0, c_white, 1);
	}
	
	if (minigames_row_selected < 2) {
		draw_sprite_ext(bind_to_key(global.actions.down.button), 0, minigames_x + draw_w / 2, draw_h - 30, 0.5, 0.5, 0, c_white, 1);
	}
	
	draw_sprite_ext(bind_to_key(global.actions.left.button), 0, minigames_x + 30, draw_h / 2, 0.5, 0.5, 0, c_white, 1);
	draw_sprite_ext(bind_to_key(global.actions.right.button), 0, minigames_x + draw_w - 30, draw_h / 2, 0.5, 0.5, 0, c_white, 1);

	var info_x = menu_x + menu_sep * 2;
	
	if (minigame_selected != null) {
		draw_set_font(fntFilesButtons);
		draw_set_halign(fa_center);
		draw_text_color_outline(info_x + draw_w / 2, 10, minigame_selected.reference.title, c_red, c_red, c_fuchsia, c_fuchsia, 1, c_black);
		draw_sprite(minigame_selected.portrait, 0, info_x + 140, 150);
		draw_sprite_stretched(sprFangameMark, 1, info_x + 300, 95, 150, 114);
		gpu_set_colorwriteenable(true, true, true, false);
		draw_sprite_stretched(sprMinigamesFangames, minigame_selected.reference.preview, info_x + 300, 95, 150, 114);
		gpu_set_colorwriteenable(true, true, true, true);
		draw_sprite_stretched(sprFangameMark, 0, info_x + 300, 95, 150, 114);
		draw_set_font(fntFilesData);
		draw_text_outline(info_x + draw_w / 2, 250, minigame_selected.reference.fangame_name, c_black);
		var colors = minigame_colors[minigames_row_selected];
		
		switch (minigames_row_selected) {
			case 0:
				for (var i = 1; i <= global.player_max; i++) {
					var square_x = info_x + 91 + 80 * (i - 1);
					draw_box(square_x, 280, 40, 40, (array_contains(colors, i)) ? c_blue : c_red, player_color_by_turn(i), 0.85,, 3);
					draw_sprite(get_skin_pose_object(focus_player_by_id(i), "Idle"), 0, square_x + 21, 280 + 23);
					
					if (i != global.player_max) {
						draw_text_color_outline(square_x + 60, 290, "VS", c_orange, c_orange, c_yellow, c_yellow, 1, c_black);
					}
				}
				break;
				
			case 1:
				var players = [colors[0]];
				
				for (var i = 1; i <= global.player_max; i++) {
					if (!array_contains(players, i)) {
						array_push(players, i);
					}
				}
			
				for (var i = 1; i <= global.player_max; i++) {
					if (i == 1) {
						var square_x = info_x + 140;
					} else {
						var square_x = info_x + 140 + 80 + 40 * (i - 2);
					}
					
					draw_box(square_x, 280, 40, 40, (array_contains(colors, players[i - 1])) ? c_blue : c_red, c_white, 0.85,, 3);
					draw_sprite(get_skin_pose_object(focus_player_by_id(players[i - 1]), "Idle"), 0, square_x + 21, 280 + 23);
					
					if (i == 1) {
						draw_text_color_outline(square_x + 60, 290, "VS", c_orange, c_orange, c_yellow, c_yellow, 1, c_black);
					}
				}
				break;
				
			case 2:
				var players = [colors[0], colors[1]];
				
				for (var i = 1; i <= global.player_max; i++) {
					if (!array_contains(players, i)) {
						array_push(players, i);
					}
				}
			
				for (var i = 1; i <= global.player_max; i++) {
					if (i <= 2) {
						var square_x = info_x + 140 + 40 * (i - 1);
					} else {
						var square_x = info_x + 140 + 80 + 40 * (i - 2);
					}
					
					draw_box(square_x, 280, 40, 40, (array_contains(colors, players[i - 1])) ? c_blue : c_red, c_white, 0.85,, 3);
					draw_sprite(get_skin_pose_object(focus_player_by_id(players[i - 1]), "Idle"), 0, square_x + 21, 280 + 23);
					
					if (i == 2) {
						draw_text_color_outline(square_x + 60, 290, "VS", c_orange, c_orange, c_yellow, c_yellow, 1, c_black);
					}
				}
				break;
		}
	}
}

surface_reset_target();

draw_sprite_stretched_ext(sprBoxFill, 2, draw_x, draw_y, draw_w, draw_h, (room == rParty) ? #3B8A66 : #3B8A66, 0.75);
draw_surface(surf, draw_x + 4, draw_y + 4);
draw_sprite_stretched_ext(sprBoxFrame, 0, draw_x, draw_y, draw_w, draw_h, c_yellow, 1);
var text = new Text(fntDialogue);
text.set(draw_action(global.actions.jump) + " Confirm");
text.draw(draw_x, draw_y + draw_h + 5);
text.set(draw_action(global.actions.shoot) + " Cancel");
text.draw(draw_x + draw_w - 120, draw_y + draw_h + 5);