sprite_index = choose(sprMinigame4vs_Sky_Clouds, sprMinigame4vs_Sky_Clouds2);
depth = layer_get_depth("Tiles") - 1;
image_alpha = 0;
sprite = sprite_duplicate(sprite_index);
sprite_set_speed(sprite, 0, spritespeed_framespersecond);
sprite_index = sprite;
image_index = irandom(image_number - 1);
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