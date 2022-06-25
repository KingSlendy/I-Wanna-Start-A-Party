if (broke) {
	exit;	
}

if (other.image_xscale > 1) {
	with (objPlayerBase) {
		if (image_xscale == 1) {
			hspeed = 0;
			player_kill();
		}
	}
	
	minigame4vs_points(other.network_id);
	next_seed_inline();
	hspeed = irandom_range(-3, 3);
	vspeed = irandom_range(-6, -3);
	gravity = 0.3;
	broke = true;
	minigame_finish(true);
	audio_play_sound(sndBlockBreak, 0, false);
}
