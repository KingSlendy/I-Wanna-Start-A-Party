///@desc Coin Lose Animation
var focus = focused_player();
var c = instance_create_layer(focus.x, focus.y, "Actors", objCoin);
c.vspeed = -8;

if (++animation_amount == abs(amount)) {
	alarm[11] = 20;
	exit;
}

alarm[2] = get_frames(0.15);