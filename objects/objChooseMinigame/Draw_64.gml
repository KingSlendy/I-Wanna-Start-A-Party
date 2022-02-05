draw_set_alpha(alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

draw_set_alpha(minigames_alpha);
var minigames_total_height = minigames_height * minigame_total;
var minigames_x = display_get_gui_width() / 2 - minigames_width / 2;
var minigames_y = display_get_gui_height() / 2 - minigames_total_height / 2 - minigames_height / 2;

for (var i = 0; i < minigame_total; i++) {
	draw_box(minigames_x, minigames_y + minigames_height * i, minigames_width, minigames_height, (i == global.choice_selected) ? c_gray : c_dkgray, c_orange);
}

draw_set_alpha(1);