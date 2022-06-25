with (points_teams[1][0]) {
	sprite_index = (hspeed == 0) ? skin[$ "Idle"] : skin[$ "Run"];
}

if (info.is_finished) {
	exit;
}

for (var i = 0; i < array_length(press_actions); i++) {
	var action = press_actions[i];
	
	if (solo_action != null && !solo_correct && !solo_wrong) {
		if (global.actions[$ action].pressed(points_teams[1][0].network_id) || (array_length(network_solo_actions) > 0 && network_solo_actions[0] == action)) {
			if (action == solo_action) {
				with (points_teams[1][0]) {
					hspeed = 3;
				}
				
				solo_correct = true;
			} else {
				solo_wrong = true;
			}
			
			other.alarm[4] = get_frames(1);
			
			if (array_length(network_solo_actions) == 0) {
				buffer_seek_begin();
				buffer_write_action(ClientTCP.Minigame1vs3_Chase_Solo);
				buffer_write_data(buffer_string, action);
				network_send_tcp_packet();
			} else {
				array_delete(network_solo_actions, 0, 1);
			}
			
			break;
		}
	}

	if (team_action != null && !team_correct && !team_wrong) {
		if (global.actions[$ action].pressed(points_teams[0][team_turn].network_id)  || (array_length(network_team_actions) > 0 && network_team_actions[0] == action)) {
			if (action == team_action) {
				for (var j = 0; j < array_length(points_teams[0]); j++) {
					with (points_teams[0][j]) {
						hspeed = 3;
					}
				}
				
				with (objMinigame1vs3_Chase_Gradius) {
					image_index = 1;
					hspeed = 3;
				}
				
				team_correct = true;
			} else {
				team_wrong = true;
			}
			
			other.alarm[5] = get_frames(1);
			
			if (array_length(network_team_actions) == 0) {
				buffer_seek_begin();
				buffer_write_action(ClientTCP.Minigame1vs3_Chase_Team);
				buffer_write_data(buffer_string, action);
				network_send_tcp_packet();
			} else {
				array_delete(network_team_actions, 0, 1);
			}
			
			break;
		}
	}
}
