if (!surface_exists(surf)) {
	surf = surface_create(draw_w - 8, 408 - 112);
}

surface_set_target(surf);
draw_clear_alpha(0, c_black);

for (var i = -2; i <= 2; i++) {
	var row = store_stock[store_row];
	var location = (store_selected[store_row] + array_length(row) + i) % array_length(row);
	var stock = row[location];
	var box_x = remap(store_x, 400 - 150, 400 + 150, -draw_w, draw_w) + draw_w * i;
	stock.info(box_x, 0);
}

surface_reset_target();

draw_sprite_stretched_ext(sprBoxFill, 2, draw_x, draw_y, draw_w, draw_h, #F2C394, 0.75);
draw_set_alpha(store_alpha);
draw_surface(surf, draw_x + 4, draw_y + 4);
draw_set_alpha(1);
draw_sprite_stretched_ext(sprBoxFrame, 0, draw_x, draw_y, draw_w, draw_h, c_white, 1);
draw_sprite_ext(global.actions.left.bind(), 0, draw_x - 22, draw_y + draw_h / 2, 0.5, 0.5, 0, c_white, 1);
draw_sprite_ext(global.actions.right.bind(), 0, draw_x + draw_w + 22, draw_y + draw_h / 2, 0.5, 0.5, 0, c_white, 1);
draw_sprite_ext(global.actions.up.bind(), 0, 400, 16, 0.5, 0.5, 0, c_white, 1);
draw_sprite_ext(global.actions.down.bind(), 0, 400, draw_y + draw_h + 16, 0.5, 0.5, 0, c_white, 1);
controls_text.set(draw_action(global.actions.jump) + " Buy");
controls_text.draw(draw_x, draw_y + draw_h + 5);
controls_text.set(draw_action(global.actions.shoot) + " Back");
controls_text.draw(draw_x + draw_w - 120, draw_y + draw_h + 5);

var sorting = "";

switch (store_sort[store_row]) {
	case 0: sorting = language_get_text("STORE_SORTED_DEFAULT"); break;
	case 1: sorting = language_get_text("STORE_SORTED_ASCENDING"); break;
	case 2: sorting = language_get_text("STORE_SORTED_DESCENDING"); break;
	case 3: sorting = language_get_text("STORE_SORTED_NAME"); break;
}

controls_text.set(draw_action(global.actions.misc) + language_get_text("STORE_SORTED_BY") + ": " + sorting);
controls_text.draw(draw_x, draw_y + draw_h + 230);
draw_collected_coins(400, draw_y + draw_h + 60);