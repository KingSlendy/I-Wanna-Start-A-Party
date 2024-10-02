if (room == rMinigame4vs_Jingle && sledge != null) {
	y = ystart - abs(sledge.ystart - sledge.y);
}

if (room == rMinigame4vs_Crates) {
	if (!spinning) {
		if (global.actions.shoot.pressed(network_id)) {
			alarm_call(1, 0.5);
			audio_play_sound(sndSpin, 0, false);
			spin_index = 0;
			spinning = true;
		}
	} else {
		spin_index += 0.54;
		spin_index %= sprite_get_number(sprPlayerSpin);
		xscale = (floor(spin_index) == 0) ? 1 : -1;
	}
}