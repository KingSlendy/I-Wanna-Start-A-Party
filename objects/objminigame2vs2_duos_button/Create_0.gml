depth = layer_get_depth("Tiles") - 1;

function press_button(network = true) {
	image_index = 1;
	audio_play_sound(sndMinigame2vs2_Buttons_Press, 0, false);
	
	if (trg < 8) {
		alarm_call(0, 0.1);
	} else {
		var other_trg;
			
		switch (trg) {
			case 8: other_trg = 9; break;
			case 9: other_trg = 8; break;
			case 10: other_trg = 11; break;
			case 11: other_trg = 10; break;
		}
		
		with (object_index) {
			if (trg == other_trg) {
				alarm_call(0, 0.1);
			}
		}
	}
	
	with (objMinigame2vs2_Duos_Block) {
		if (trg == other.trg) {
			button_event();
		}
	}
	
	with (objMinigame2vs2_Duos_Platform) {
		if (trg == other.trg) {
			button_event();
		}
	}
	
	with (objMinigame2vs2_Duos_Leek) {
		if (trg == other.trg) {
			button_event();
		}
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Duos_Button);
		buffer_write_data(buffer_u8, trg);
		network_send_tcp_packet();
	}
}

alarms_init(1);

alarm_create(function() {
	image_index = 0;
});