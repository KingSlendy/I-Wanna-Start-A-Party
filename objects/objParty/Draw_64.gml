draw_set_font(fntPlayerInfo);
draw_set_color(c_white);

for (var i = 0; i < global.player_max; i++) {
	draw_box(0, 32 * i, 160, 32, player_color_by_turn(i + 1),, 0.8);
	draw_text_outline(5, 32 * i + 5, focus_player_by_id(i + 1).network_name, c_black);
}

var draw_x = 160;
var draw_y = 32;
var draw_w = 32 * 15;
var draw_h = 32 * 15 - 112;
draw_box(draw_x, draw_y, draw_w, draw_h, #3B8A66, c_gray);

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
	draw_text_outline(save_x + 270, save_y + 140, string_interp("Turn: {0}/{1}", save_turn, save_max_turns), c_black);
}

var text = new Text(fntDialogue);

for (var i = 0; i < 2; i++) {
	var option_x = save_x + 290;
	var option_y = save_y + 270 + 45 * i;
	draw_box(option_x, option_y, 130, 40, (i == save_selected) ? c_gray : c_dkgray);
	text.set(draw_option_afford((i == 0) ? "Resume" : "Decline", true, (i == save_selected)));
	text.draw(option_x + 10, option_y + 6); 
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
		
		if (!is_selected && already_selected) {
			color = c_black;
		}
		
		var box_x = menu_x + skin_w * c;
		var box_y = skin_y + skin_h * r;
		draw_set_alpha(remap(point_distance(box_y, 0, skin_h, 0), 0, skin_h, 1, 0.5));
		//draw_set_alpha((r == 0) ? 1 : 0.5);
		draw_box(box_x, box_y, skin_w, skin_h, c_dkgray, color);
		draw_sprite_ext(get_skin(skin)[$ "Idle"], 0, box_x + skin_w / 2 + 3, box_y + skin_h / 2 + 6, 3, 3, 0, (!already_selected) ? c_white : c_gray, draw_get_alpha());
		draw_set_alpha(1);
	}
}

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

surface_reset_target();

draw_surface(surf, draw_x + 4, draw_y + 4);
