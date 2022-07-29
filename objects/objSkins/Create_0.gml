fade_alpha = 1;
fade_start = true;
back = false;
surf = noone;
timer = 0;
dir = 1;
buying = -1;

skin_selected = 0;
skin_target_selected = 0;
skin_x = 400;
skin_target_x = 400;

held_time = 0;

for (var i = 0; i < array_length(global.skins); i++) {
	global.skins[i].shop_price = global.skins[i].price;
}