var xx = round(x);
var yy = round(y);
draw_sprite_ext(sprPlayerGolf, 0, xx, yy, image_xscale, image_yscale, image_angle, player_color_by_turn(player_info_by_id(network_id).turn), image_alpha);
draw_sprite_ext(sprite_index, 0, xx + 1, yy + 3, 0.5, 0.5, image_angle, image_blend, image_alpha);

if (frozen) {
	exit;
}

var length = 100;

if (aiming) {
    draw_set_color(c_black);
    draw_line_width(xx, yy, xx + lengthdir_x(length, aim_angle), yy + lengthdir_y(length, aim_angle), 2);
}

if (powering) {
    var yyy = (yy + 40);
    var h = 20;
    draw_set_color(c_black);
    draw_rectangle(xx - length / 2 - 1, yyy - 1, xx + length / 2 + 1, yyy + h + 1, true);
    draw_rectangle(xx - length / 2 - 2, yyy - 2, xx + length / 2 + 2, yyy + h + 2, true);
    draw_set_color(make_color_hsv(90 - aim_power * 90, 255, 255));
    draw_rectangle(xx - length / 2, yyy, xx - length / 2 + length * aim_power, yyy + h, false);
}