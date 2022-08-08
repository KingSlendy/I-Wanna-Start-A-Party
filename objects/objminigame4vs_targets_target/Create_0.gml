sprite_index = sprite;
target_dir = 1;
anglestart = 360 / 3 * num;

function restore_target() {
	visible = true;
	image_alpha = 1;
	image_index = 0;
	x = xstart;
	y = ystart;
	angle = anglestart;
	spd = 10;
	fading = false;
}

function destroy_target(network = true) {
	image_index = 1;
	fading = true;
	object_index.spd++;
	var points;
	
	switch (sprite) {
		case sprMinigame4vs_Targets_TargetRed: points = 1; break;
		case sprMinigame4vs_Targets_TargetBlue: points = 2; break;
		case sprMinigame4vs_Targets_TargetYellow: points = 3; break;
	}
	
	minigame4vs_points(player_info_by_turn(objMinigameController.player_turn).network_id, points);
	audio_play_sound(sndMinigame4vs_Targets_TargetBreak, 0, false);
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Targets_DestroyTarget);
		buffer_write_data(buffer_s32, xstart);
		buffer_write_data(buffer_s32, ystart);
		buffer_write_data(buffer_u8, num);
		network_send_tcp_packet();
	}
}

restore_target();