if (enabled) {
	var player = instance_place(x, y - 1, objPlayerBase);
	
	if (player != noone) {
		if (is_player_local(player.network_id)) {
			with (player) {
				if (is_player_local(network_id)) {
					vspd = -12;
					reset_jumps();
				}
			}
		}
		
		image_index = 1;
		audio_play_sound(sndMinigame2vs2_Springing_Spring, 0, false);
		alarm[0] = get_frames(0.25);
	}
}