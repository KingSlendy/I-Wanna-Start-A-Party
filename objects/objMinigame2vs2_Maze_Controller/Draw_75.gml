var draw_w = camera_get_view_width(view_camera[0]);
var draw_h = camera_get_view_height(view_camera[0]);

for (var i = 0; i < global.player_max; i++) {
	draw_set_color(info.player_colors[(i >= 2)]);
	var draw_x = draw_w * (i div 2);
	var draw_y = draw_h * (i % 2);
	draw_box(draw_x, draw_y, draw_w, draw_h, c_white, draw_get_color(), 0);
	//draw_sprite_stretched();
	//draw_rectangle(draw_x, draw_y, draw_x + draw_w, draw_y + draw_h, true);
}