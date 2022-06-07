ang = (ang + 360 + 2) % 360;

gpu_set_blendmode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y + 4 * dcos(ang), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
gpu_set_blendmode(bm_normal);
