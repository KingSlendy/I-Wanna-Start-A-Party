///@desc Coin Gain Animation
var c = instance_create_layer(focus_player.x, focus_player.y - 69, "Actors", objCoin);
c.focus_player = focus_player;
c.vspeed = 6;

if (++animation_amount == amount) {
	alarm[11] = 20;
	exit;
}

alarm[1] = get_frames(0.15);