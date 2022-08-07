with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

event_inherited();
minigame_start = minigame1vs3_start;
minigame_time_end = function() {
	minigame_time = -1;
	
	with (objMinigame1vs3_Showdown_Block) {
		if (selecting) {
			if (number == -1) {
				number = show;
			}
			
			selecting = false;
		}
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		if (is_player_local(i) && !focus_player_by_id(i).lost) {
			buffer_seek_begin();
			buffer_write_action(ClientTCP.Minigame1vs3_Showdown_Block);
			buffer_write_data(buffer_u8, i);
			
			with (objMinigame1vs3_Showdown_Block) {
				if (player_id == i) {
					buffer_write_data(buffer_u8, number);
					break;
				}
			}
			
			network_send_tcp_packet();
		}
	}
	
	with (objMinigame1vs3_Showdown_Block) {
		if (self.number == -1) {
			return;
		}
	}
			
	objMinigameController.alarm[4] = get_frames(1);
}

action_end = function() {
	alarm[1] = 0;
	alarm[4] = 0;
	
	with (objMinigame1vs3_Showdown_Block) {
		number = -1;
		selecting = false;
	}
}

player_check = objPlayerPlatformer;

rounds = -1;