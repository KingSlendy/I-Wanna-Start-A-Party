if (room == rMinigame4vs_Jingle && sledge != null) {
	y = ystart - abs(sledge.ystart - sledge.y);
}

if (room == rMinigame4vs_Crates) {
	if (!stunned) {
		image_alpha = 1;
		
		if (!spinning) {
			if (!frozen && global.actions.shoot.pressed(network_id)) {
				sprite_index = skin[$ "Fall"];
				alarm_call(1, 0.45);
				audio_play_sound(sndSpin, 0, false);
				spin_index = 0;
				spinning = true;
			}
		} else {
			spin_index += 0.54;
			spin_index %= sprite_get_number(sprPlayerSpin);
			xscale = (floor(spin_index) == 0) ? 1 : -1;
		}
	} else {
		image_alpha = 0.5;
	}
}