with (minigame1vs3_solo()) {
	if (!is_player_local(network_id)) {
		break;
	}
	
	sprite_index = (hspeed == 0) ? skin[$ "Idle"] : skin[$ "Run"];
}

if (info.is_finished) {
	exit;
}

for (var i = 0; i < array_length(press_actions); i++) {
	var action = press_actions[i];
	
	if (solo_action != null && !solo_correct && !solo_wrong) {
		if (global.actions[$ action].pressed(minigame1vs3_solo().network_id) || (array_length(network_solo_actions) > 0 && network_solo_actions[0] == action)) {
			var advance = (solo_advance == solo_action_total - 1);
			
			if (action == solo_action) {
				if (advance) {
					with (minigame1vs3_solo()) {
						if (is_player_local(network_id)) {
							if (network_id) {
								hspeed = 5;
							}
						}
					}
				}
				
				solo_correct = true;
				audio_play_sound(sndMinigame1vs3_Race_Correct, 0, false);
			} else {
				solo_wrong = true;
				audio_play_sound(sndMinigame1vs3_Race_Wrong, 0, false);
			}
			
			alarm_frames(4, (!advance && !solo_wrong) ? 1 : 37);
			
			if (array_length(network_solo_actions) == 0) {
				buffer_seek_begin();
				buffer_write_action(ClientTCP.Minigame1vs3_Race_Solo);
				buffer_write_data(buffer_string, action);
				network_send_tcp_packet();
			} else {
				array_delete(network_solo_actions, 0, 1);
			}
		}
	}

	if (team_action != null && !team_correct && !team_wrong) {
		if (global.actions[$ action].pressed(minigame1vs3_team(other.team_turn).network_id) || (array_length(network_team_actions) > 0 && network_team_actions[0] == action)) {
			var advance = (team_advance == team_action_total - 1);
			
			if (action == team_action) {
				if (advance) {
					for (var j = 0; j < minigame1vs3_team_length(); j++) {
						with (minigame1vs3_team(j)) {
							if (is_player_local(network_id)) {
								hspeed = 5;
							}
						}
					}
				
					with (objMinigame1vs3_Race_Gradius) {
						image_index = 1;
						hspeed = 5;
					}
				}
				
				team_advance++;
				team_correct = true;
				audio_play_sound(sndMinigame1vs3_Race_Correct, 0, false);
			} else {
				team_wrong = true;
				audio_play_sound(sndMinigame1vs3_Race_Wrong, 0, false);
			}
			
			alarm_frames(5, (!advance && !team_wrong) ? 7 : 37);
			
			if (array_length(network_team_actions) == 0) {
				buffer_seek_begin();
				buffer_write_action(ClientTCP.Minigame1vs3_Race_Team);
				buffer_write_data(buffer_string, action);
				network_send_tcp_packet();
			} else {
				array_delete(network_team_actions, 0, 1);
			}
		}
	}
}