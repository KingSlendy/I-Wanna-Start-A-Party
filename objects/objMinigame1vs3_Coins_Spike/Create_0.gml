event_inherited();
threw = false;
follow = null;
count = 0;

function throw_spike(network = true) {
	hspeed = 7;
	gravity = 0.3;
	threw = true;
	audio_play_sound(sndMinigame1vs3_Coins_Throw, 0, false);
	
	if (network) {
		vspeed = follow.vspd;
		
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_Coins_ThrowSpike);
		buffer_write_data(buffer_u32, count);
		buffer_write_data(buffer_s32, x);
		buffer_write_data(buffer_s32, y);
		buffer_write_data(buffer_f16, vspeed);
		network_send_tcp_packet();
	}
	
	follow = null;
}
