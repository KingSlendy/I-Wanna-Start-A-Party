draw_set_font(fntPlayerInfo);
draw_set_color(c_white);

for (var i = 0; i < global.player_max; i++) {
	var player = focus_player_by_id(i + 1);
	var box_w = 110;
	var box_h = 32;
	var box_x = player.x - box_w / 2;
	var box_y = display_get_gui_height() - box_h;
	draw_box(box_x, box_y, box_w, box_h, player_color_by_turn(i + 1),, 0.8,, 1);
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
	draw_text_outline(save_x + 290, save_y + 170, string_interp("Bonus: {0}", "ON"), c_black);
	var text = new Text(fntDialogue);

	for (var i = 0; i < 2; i++) {
		var option_x = save_x + 290;
		var option_y = save_y + 270 + 45 * i;
		draw_box(option_x, option_y, 130, 40, (i == save_selected) ? c_ltgray : c_dkgray,,,, 1);
		text.set(draw_option_afford((i == 0) ? "Resume" : "Decline", true, (i == save_selected)));
		text.draw(option_x + 15, option_y + 6); 
	}
}

//Skin selection
var length = array_length(skins)

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
		//draw_set_alpha((r == 0) ? 1 : 0.5);
		draw_box(box_x, box_y, skin_w, skin_h, c_dkgray, color);
		
		if (!is_selected && already_selected) {
			gpu_set_blendmode(bm_add);
			draw_box(box_x, box_y, skin_w, skin_h, c_white, color, 0);
			gpu_set_blendmode(bm_normal);
		}
		
		//if (array_contains(global.collected_skins, skin)) {
			var skin_sprite = get_skin(skin)[$ "Idle"];
		//} else {
		//	var skin_sprite = sprPlayerIdle;
		//}
		
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
	text.set("Turns: " + string(20) + " turns{COLOR,FFFFFF}");
	text.draw(box_x + 100, box_y + box_y + 32 + board_h + 10);
	text.set("Bonus: " + "ON{COLOR,FFFFFF}");
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
	
}

surface_reset_target();

draw_sprite_stretched_ext(sprBoxFill, 2, draw_x, draw_y, draw_w, draw_h, #3B8A66, 1);
draw_surface(surf, draw_x + 4, draw_y + 4);
draw_sprite_stretched_ext(sprBoxFrame, 0, draw_x, draw_y, draw_w, draw_h, c_yellow, 1);
var text = new Text(fntDialogue);
text.set(draw_action(global.actions.jump) + ": Confirm");
text.draw(draw_x, draw_y + draw_h + 5);
text.set(draw_action(global.actions.shoot) + ": Cancel");
text.draw(draw_x + draw_w - 120, draw_y + draw_h + 5);
