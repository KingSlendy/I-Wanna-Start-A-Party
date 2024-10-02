draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale * xscale, image_yscale, image_angle, image_blend, image_alpha);

if (room == rMinigame4vs_Crates && spinning) {
	draw_sprite_ext(sprPlayerSpin, spin_index, x, y, xscale, orientation, image_angle, image_blend, image_alpha);
}