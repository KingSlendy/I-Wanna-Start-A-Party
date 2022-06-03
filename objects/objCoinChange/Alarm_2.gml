///@desc Coin Lose Animation
if (amount == 0) {
	alarm[11] = 20;
	exit;
}

var c = instance_create_layer(focus_player.x, focus_player.y, "Actors", objCoin);
c.focus_player = focus_player;
c.vspeed = -8;
audio_play_sound(sndCoinLose, 0, false);

if (++animation_amount == abs(amount)) {
	alarm[11] = 20;
	exit;
}

alarm[2] = max(3, get_frames(0.15 - abs(amount) * 0.005));