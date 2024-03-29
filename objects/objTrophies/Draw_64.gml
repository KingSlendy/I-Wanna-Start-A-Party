var draw_x = 224;
var draw_y = 64;
var draw_w = 32 * 11;
var draw_h = 32 * 10 - 112;

if (!surface_exists(surf)) {
	surf = surface_create(344, 408 - 112);
}

surface_set_target(surf);
draw_clear_alpha(0, c_black);

for (var i = -2; i <= 2; i++) {
	var location = (trophy_selected + array_length(global.trophies) + i) % array_length(global.trophies);
	var trophy = global.trophies[location];
	var box_x = remap(trophy_x, 400 - 200, 400 + 200, -draw_w, draw_w) + draw_w * i;
	draw_sprite_stretched(sprFangameMark, 1, box_x + 10, 10, box_x + draw_w - 30, 40);
	language_set_font(global.fntTrophies);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_info(box_x + draw_w / 2 - 10, 30, (achieved_trophy(trophy.image - 1)) ? trophy.name : "??????", draw_w - 10);
	language_set_font(global.fntTrophiesDesc);
	draw_set_color((achieved_trophy(trophy.image - 1)) ? c_white : c_ltgray)
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_sprite_stretched(sprFangameMark, 1, box_x + 10, 60, box_x + draw_w - 30, 130);
	
	var description = trophy.description;
	
	switch (trophy.state()) {
		case TrophyState.Unknown: description = "??????"; break;
		case TrophyState.Hint: description = trophy.short; break;
	}
	
	descriptions_text.set(description);
	descriptions_text.draw(box_x + 20, 70, draw_w - 50, c_black, draw_get_color(), draw_get_color(), draw_get_color(), draw_get_color());
}

surface_reset_target();

draw_sprite_stretched_ext(sprBoxFill, 2, draw_x, draw_y, draw_w, draw_h, #F2C394, 0.75);
draw_surface(surf, draw_x + 4, draw_y + 4);
draw_sprite_stretched_ext(sprBoxFrame, 0, draw_x, draw_y, draw_w, draw_h, c_white, 1);
draw_sprite_ext(global.actions.left.bind(), 0, draw_x - 22, draw_y + draw_h / 2, 0.5, 0.5, 0, c_white, 1);
draw_sprite_ext(global.actions.right.bind(), 0, draw_x + draw_w + 22, draw_y + draw_h / 2, 0.5, 0.5, 0, c_white, 1);
draw_collected_coins(400, draw_y + draw_h + 60);
var trophy = global.trophies[trophy_selected];
var buy = "";

switch (trophy.state()) {
	case TrophyState.Unknown: buy = draw_action(global.actions.jump) + " " + language_get_text("TROPHIES_HINT"); break;
	case TrophyState.Hint: buy = draw_action(global.actions.jump) + " " + language_get_text("TROPHIES_SPOILER"); break;
}

controls_text.set(buy);
controls_text.draw(draw_x, draw_y + draw_h + 5);
controls_text.set(draw_action(global.actions.shoot) + " " + language_get_text("WORD_GENERIC_MENU_BACK"));
controls_text.draw(draw_x + draw_w - 115, draw_y + draw_h + 5);