spin = true;
scale = 1;

function stop(network = true) {
	if (network) {
		scale = round(scale);
		event_perform(ev_step, ev_step_normal);
		scale = round(scale);
	}
	
	spin = false;
	objPlayerBase.frozen = true;
	alarm_call(0, 1);
	
	with (objMinigameController) {
		alarm_call(4, 1.2);
		alarm_stop(10);
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Bullets_Stop);
		buffer_write_data(buffer_u8, image_index);
		buffer_write_data(buffer_u8, scale);
		network_send_tcp_packet();
	}
}

alarms_init(1);

alarm_create(function() {
	with (objMinigameController) {
		with (focus_player_by_turn(player_turn)) {
			if (!is_player_local(network_id)) {
				break;
			}
			
			hspd = -max_hspd;
		}
	}
});