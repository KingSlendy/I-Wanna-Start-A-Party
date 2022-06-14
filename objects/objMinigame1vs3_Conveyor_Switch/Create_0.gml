function activate(image, network = false) {
	switch (image_index) {
		case 0:
			var c_spr = sprMinigame1vs3_Conveyor_ConveyorRight;
			var c_spd = 15;
			break;
		
		case 1:
			var c_spr = sprMinigame1vs3_Conveyor_ConveyorLeft;
			var c_spd = -15;
			break;
		
		case 2:
			var c_spr = sprMinigame1vs3_Conveyor_ConveyorStill;
			var c_spd = 0;
			break;
	}

	if (objMinigame1vs3_Conveyor_Conveyor.sprite_index != c_spr) {
		with (objMinigame1vs3_Conveyor_Conveyor) {
			sprite_index = c_spr;
			spd = c_spd;
		}
	}
	
	if (!network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_Conveyor_Switch);
		buffer_write_data(buffer_u8, image_index);
		network_send_tcp_packet();
	}
}
