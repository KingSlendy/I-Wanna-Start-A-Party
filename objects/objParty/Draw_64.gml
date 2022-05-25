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
var length = array_length(skins)

for (var r = -2; r <= 2; r++) {
	var now_r = (skin_row + length + r) % length;
	var skin_c = skins[now_r];
	
	for (var c = 0; c < array_length(skin_c); c++) {
		var is_selected = (now_r == skin_target_row && c == skin_col);
		var color = (is_selected) ? player_color_by_turn(skin_player + 1) : c_white;
		var box_x = 118 * c;
		var box_y = skin_y + 118 * r;
		draw_set_alpha(remap(point_distance(box_y, 0, 118, 0), 0, 118, 1, 0.5));
		//draw_set_alpha((r == 0) ? 1 : 0.5);
		draw_box(box_x, box_y, 118, 118, c_dkgray, color);
		var skin = skin_c[c];
		draw_sprite_ext(get_skin(skin)[$ "Idle"], 0, box_x + 118 / 2 + 3, box_y + 118 / 2 + 6, 3, 3, 0, c_white, draw_get_alpha());
		draw_set_alpha(1);
	}
}

surface_reset_target();

draw_surface(surf, draw_x + 4, draw_y + 4);
