if (enabled) {
	var player = instance_place(x, y - 1, objPlayerBase);
	
	if (player != noone) {
		with (player) {
			if (is_player_local(network_id)) {
				vspd = -12;
				reset_jumps();
			}
		}
		
		image_index = 1;
		audio_play_sound(sndMinigame2vs2_Springing_Spring, 0, false);
		alarm_call(0, 0.25);
	}
}