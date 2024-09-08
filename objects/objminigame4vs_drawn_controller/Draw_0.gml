draw_set_alpha(0.1);
draw_set_color(c_navy);

for (var gi = 0; gi <= room_height; gi += 32) {
    draw_line(0, gi, room_width, gi);
}
	
draw_set_color(c_black);
draw_set_alpha(1);

event_inherited();