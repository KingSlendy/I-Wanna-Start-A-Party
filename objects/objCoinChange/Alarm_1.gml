///@desc Coin Gain Animation
if (amount == 0) {
	alarm[11] = 20;
	exit;
}

var c = instance_create_layer(focus_player.x, focus_player.y - 69, "Actors", objCoin);
c.focus_player = focus_player;
c.vspeed = 6;

if (++animation_amount == abs(amount)) {
	alarm[11] = 20;
	exit;
}

alarm[1] = max(3, get_frames(0.15 - abs(amount) * 0.005));