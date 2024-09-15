if (trial_is_title(CHALLENGE_MEDLEY) && room == rMinigame2vs2_Maze) {
	visible = false;
}

function treasure_block_hit(network_id, network = true) {
	repeat (4) {
		instance_create_layer(x, y, "Collisions", objMinigame4vs_Treasure_BlockEffect);
	}
		
	audio_play_sound(sndMinigame4vs_Treasure_Block, 0, false);
		
	if (++image_index > image_number - 1) {
		with (objMinigameController) {
			mp_grid_clear_cell(grid, other.x / 32, other.y / 32);
		}
		
		instance_destroy();
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Treasure_BlockHit);
		buffer_write_data(buffer_u8, network_id);
		buffer_write_data(buffer_s32, x);
		buffer_write_data(buffer_s32, y);
		network_send_tcp_packet();
	}
}