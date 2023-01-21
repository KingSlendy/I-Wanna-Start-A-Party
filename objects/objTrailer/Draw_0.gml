LIVE

if (!trailer) {
	exit;
}

draw_set_alpha(trailer_release_alpha);
draw_set_font(fntTitle);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(room_width / 2, 50, "RELEASE DATE");
draw_text(250, 300, "/");
draw_text(450, 300, "/");
draw_set_alpha(1);

if (!trailer_release_dice) {
	trailer_release_alpha += 0.01;

	if (trailer_release_alpha >= 1.2) {
		instance_create_layer(150, 380, "Actors", objTrailerDice);
		alarm[0] = 100;
		trailer_release_dice = true;
	}
}