draw_sprite(sprites[0], 0, 0, 0);

if (sprites[1] == noone) {
	exit;
}

draw_set_color(c_black);
draw_rectangle(0, 0, 800, 608, false);
wave_transition(sprites, wave);