///@desc Coin Lose Animation
var c = instance_create_layer(focus_player.x, focus_player.y, "Actors", objCoin);
c.focus_player = focus_player;
c.vspeed = -8;

if (++animation_amount == abs(amount)) {
	alarm[11] = 20;
	exit;
}

alarm[2] = get_frames(0.15);