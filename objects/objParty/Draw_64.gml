draw_set_font(fntPlayerInfo);
draw_set_color(c_white);

for (var i = 0; i < global.player_max; i++) {
	draw_box(0, 32 * i, 160, 32, player_color_by_turn(i + 1),, 0.8);
	draw_text_outline(5, 32 * i + 5, focus_player_by_id(i + 1).network_name, c_black);
}

var draw_x = 160;
var draw_y = 32;
var draw_w = 32 * 15;
var draw_h = 32 * 15 - 118;
draw_box(draw_x, draw_y, draw_w, draw_h, c_gray, c_dkgray);

if (!surface_exists(surf)) {
	surf = surface_create(472, 472 - 118);
}

surface_set_target(surf);
draw_clear_alpha(c_black, 0);
menu_x = lerp(menu_x, -menu_sep * menu_page, 0.3);

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
		
		var box_x = menu_x + 118 * c;
		var box_y = skin_y + 118 * r;
		draw_set_alpha(remap(point_distance(box_y, 0, 118, 0), 0, 118, 1, 0.5));
		//draw_set_alpha((r == 0) ? 1 : 0.5);
		draw_box(box_x, box_y, 118, 118, c_dkgray, color);
		draw_sprite_ext(get_skin(skin)[$ "Idle"], 0, box_x + 118 / 2 + 3, box_y + 118 / 2 + 6, 3, 3, 0, (!already_selected) ? c_white : c_gray, draw_get_alpha());
		draw_set_alpha(1);
	}
}

//Board selection
var box_x = menu_x + menu_sep;
var box_y = 0;
draw_sprite_stretched(sprPartyBoardMark, 1, box_x + 60, box_y + 32, 352, 224);
gpu_set_colorwriteenable(true, true, true, false);
var length = sprite_get_number(sprPartyBoardTest);

for (var i = -1; i <= 1; i++) {
	draw_sprite_stretched(sprPartyBoardTest, (board_selected + length + i) % length, box_x + 104 + 264 * i + board_x, box_y + 47, 264, 193);
}

gpu_set_colorwriteenable(true, true, true, true);
draw_sprite_stretched(sprPartyBoardMark, 0, box_x + 60, box_y + 32, 352, 224);

surface_reset_target();

draw_surface(surf, draw_x + 4, draw_y + 4);
