var draw_x = 224;
var draw_y = 32;
var draw_w = 32 * 11;
var draw_h = 32 * 13 - 112;

if (!surface_exists(surf)) {
	surf = surface_create(344, 408 - 112);
}

surface_set_target(surf);
draw_clear_alpha(0, c_black);

for (var i = -2; i <= 2; i++) {
	var skin = global.skins[(skin_selected + array_length(global.skins) + i) % array_length(global.skins)];
	var box_x = remap(skin_x, 400 - 150, 400 + 150, -draw_w, draw_w) + draw_w * i;
	draw_sprite_stretched(sprFangameMark, 1, box_x + 72, 60, 200, 152);
	draw_sprite_stretched(sprFangameMark, 0, box_x + 72, 60, 200, 152);
	draw_set_font(fntFilesButtons);
	draw_set_halign(fa_center);
	draw_text_color_outline(box_x + draw_w / 2, 10, skin.name, c_red, c_red, c_fuchsia, c_fuchsia, 1, c_black);
	draw_set_font(fntFilesData);
	draw_text_outline(box_x + draw_w / 2, 220, skin.fangame_name, c_black);
	draw_set_halign(fa_left);
	draw_text_outline(box_x + 20, 260, "Maker: " + skin.maker, c_black);
}

draw_sprite_ext(bind_to_key(global.actions.left.button), 0, 30, draw_h / 2, 0.5, 0.5, 0, c_white, 1);
draw_sprite_ext(bind_to_key(global.actions.right.button), 0, draw_w - 30, draw_h / 2, 0.5, 0.5, 0, c_white, 1);
surface_reset_target();

draw_sprite_stretched_ext(sprBoxFill, 2, draw_x, draw_y, draw_w, draw_h, #F2C394, 0.75);
draw_surface(surf, draw_x + 4, draw_y + 4);
draw_sprite_stretched_ext(sprBoxFrame, 0, draw_x, draw_y, draw_w, draw_h, c_white, 1);
var text = new Text(fntDialogue);
text.set(draw_action(global.actions.jump) + ": Buy");
text.draw(draw_x, draw_y + draw_h + 5);
text.set(draw_action(global.actions.shoot) + ": Cancel");
text.draw(draw_x + draw_w - 120, draw_y + draw_h + 5);
draw_sprite(sprCoin, 0, draw_x + 146, draw_y + draw_h + 80);
draw_set_font(fntPlayerInfo);
draw_set_valign(fa_middle);
draw_text_outline(draw_x + 166, draw_y + draw_h + 80, string(global.collected_coins), c_black);
draw_set_valign(fa_top);
