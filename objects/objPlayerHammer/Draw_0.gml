draw_sprite_ext(sprPlayerHammer, index, x, y, image_xscale, image_yscale, image_angle, player_info_by_id(network_id).space, image_alpha);

if (index == 0) {
	var xx = x - 3;
	var yy = y - 3;
} else {
	var xx = x - 5;
	var yy = y;
}

draw_sprite_ext(sprite_index, 0, xx, yy, 0.5, 0.5, image_angle, image_blend, image_alpha);