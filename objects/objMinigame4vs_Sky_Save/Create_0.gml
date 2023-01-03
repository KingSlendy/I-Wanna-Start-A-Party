next_seed_inline();
depth = layer_get_depth("Tiles") - 1;
image_alpha = 0;
sprite = sprite_duplicate(sprite_index);
sprite_set_speed(sprite, 0, spritespeed_framespersecond);
sprite_index = sprite;
image_index = irandom(image_number - 1);

if (trial_is_title(GREEN_DIVING)) {
	do {
		image_index = irandom_range(1, image_number - 1);
	} until (image_index != 1 || objMinigameController.created_green < 2);
}

if (image_index == 1) {
	objMinigameController.created_green++;
}

var dist = point_distance(x, y, 400, 304);
var dir = point_direction(x, y, 400, 304);
sprite_set_offset(sprite_index, round(lengthdir_x(dist, dir)), round(lengthdir_y(dist, dir)));
x += sprite_xoffset;
y += sprite_yoffset;
image_xscale = 0.5;
image_yscale = 0.5;
alpha_spd = 0.01;
scale_spd = 0.006;
xcenter = x;
ycenter = y;
front = false;