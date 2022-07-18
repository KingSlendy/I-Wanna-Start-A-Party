instance_destroy(other.object_index);

if (!is_player_local(other.network_id)) {
	exit;
}

sprite_index = sprMinigame4vs_Slime_SlimeShot;
image_index = 4;
player = focus_player_by_id(other.network_id);
player.frozen = true;
audio_play_sound(sndMinigame4vs_Slime_Shot, 0, false);
music_pause();
next_seed_inline();
alarm[0] = get_frames(irandom_range(2, 4));