var draw_x = 224;
var draw_y = 32;
var draw_w = 32 * 11;
var draw_h = 32 * 13 - 112;
var c = instance_create_layer(draw_x + 146, draw_y + draw_h + 80, "Actors", objNothing);
c.sprite_index = sprCoin;
c.image_speed = 0;
c.vspeed = 4;
global.collected_coins--;

if (--buying == 0) {
	exit;
}

alarm[0] = 1;
