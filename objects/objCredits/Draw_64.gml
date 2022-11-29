var draw_y = 50;

for (var i = 0; i < array_length(sections); i++) {
	draw_y = sections[i].draw((room_width - max_width) / 2, draw_y) + 30;
}