language_set_font(global.fntTitle);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
title_text = "THE FANGAME AWARDS";
title_x = 400;
title_y = 250;
title_w = string_width(title_text);
title_h = string_height(title_text);
var surf = surface_create(title_w, title_h);
surface_set_target(surf);
draw_clear_alpha(c_black, 0);
draw_text(floor(title_w / 2), floor(title_h / 2), title_text);
gpu_set_colorwriteenable(true, true, true, false);
draw_sprite_tiled(sprTitleStars, 0, 0, 0);
gpu_set_blendmode(bm_add);
draw_sprite_stretched(sprTitleGradient, 0, 0, 0, title_w, title_h);
gpu_set_blendmode(bm_normal);
gpu_set_colorwriteenable(true, true, true, true);
surface_reset_target();

title_sprite = sprite_create_from_surface(surf, 0, 0, title_w, title_h, false, false, floor(title_w / 2), floor(title_h / 2));
surface_free(surf);
var surf = surface_create(title_w, title_h);
surface_set_target(surf);
draw_clear_alpha(c_black, 0);

for (var i = 1; i <= 6; i++) {
	draw_text_transformed_color_outline(floor(title_w / 2), floor(title_h / 2) + i, title_text, 1, 1, 0, c_black, c_black, c_black, c_black, 1, c_ltgray);
}

draw_sprite(title_sprite, 0, floor(title_w / 2), floor(title_h / 2));
surface_reset_target();
text_sprite = sprite_create_from_surface(surf, 0, 0, title_w, title_h, false, false, title_w / 2, title_h / 2);
surface_free(surf);
sprite_save(text_sprite, 0, "TEXT.png");