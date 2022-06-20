var w = sprite_get_width(sprModesTrophies);
var h = sprite_get_height(sprModesTrophies);
var surf = surface_create(w, h);
surface_set_target(surf);
gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_one);
draw_sprite(sprModesTrophies, rank, w / 2, h);
draw_sprite(sprTrophyImages, image, w / 2, h - 125);
draw_set_font(fntFilesData);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text_outline(w / 2, h - 40, string(trophy + 1), c_black);
draw_set_halign(fa_left);
gpu_set_blendmode(bm_normal);
surface_reset_target();
sprite = sprite_create_from_surface(surf, 0, 0, w, h, false, false, w / 2, h / 2);
surface_free(surf);

audio_play_sound(sndTrophy, 0, false);
