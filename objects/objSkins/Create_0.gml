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

alarms_init(1);

alarm_create(function() {
	var draw_x = 224;
	var draw_y = 32;
	var draw_w = 32 * 11;
	var draw_h = 32 * 13 - 112;
	var c = instance_create_layer(draw_x + 146, draw_y + draw_h + 80, "Actors", objNothing);
	c.sprite_index = sprCoin;
	c.image_speed = 0;
	c.vspeed = 4;

	global.collected_coins -= 10;
	buying -= 10;

	if (buying == 0) {
		return;
	}

	alarm_frames(0, 1);
});