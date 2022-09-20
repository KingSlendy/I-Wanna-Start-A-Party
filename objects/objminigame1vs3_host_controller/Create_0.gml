event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_shoot = false;
		jump_total = -1;
		pick_id = null;
	}
}

minigame_camera = CameraMode.Split4;
minigame_time_valign = fa_top;
minigame_time_end = function() {
	objPlayerBase.frozen = true;
	
	if (hider) {
		with (points_teams[1][0]) {
			if (pick_id == null) {
				with (other) {
					set_pick_door(other.id, 0);
				}
			}
		}
	} else {
		with (objPlayerBase) {
			if (pick_id == null) {
				with (other) {
					set_pick_door(other.id, 0);
				}
			}
		}
	}
	
	lights = false;
	alarm_call(6, 2);
}

action_end = function() {
	lights = true;
}

player_check = objPlayerPlatformer;

current_round = 1;
lights = true;
hider = true;
surf = noone;

var size = 200;
var spot = surface_create(size, size);
surface_set_target(spot);
draw_set_color(c_white);
draw_spotlight(size / 2, size / 2, size);
surface_reset_target();
spotlight = sprite_create_from_surface(spot, 0, 0, size, size, false, false, size / 2, size / 2);
surface_free(spot);

function set_pick_door(player, pick, network = true) {
	player.pick_id = pick;
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_Host_SetPickDoor);
		buffer_write_data(buffer_u8, player.network_id);
		buffer_write_data(buffer_u64, player.pick_id);
		network_send_tcp_packet();
	}
}

alarm_override(0, function() {
	alarm_inherited(0);
	music_stop();
	alarm_stop(10);
});

alarm_override(1, function() {
	alarm_call(4, 1);
});

alarm_create(4, function() {
	lights = true;
	show_popup("ROUND " + string(current_round));
	alarm_call(5, 2);
});

alarm_create(5, function() {
	music_play(music);
	show_popup("HIDE!",,,,,, 0.25);
	points_teams[1][0].frozen = false;
	minigame_time = 15;
	alarm_call(10, 1);
});

alarm_create(6, function() {	
	if (hider) {
		if (points_teams[1][0].pick_id == null) {
			alarm_frames(6, 1);
			return;
		}
		
		objPlayerBase.frozen = false;
		
		with (points_teams[1][0]) {
			if (pick_id != 0) {
				x = pick_id.bbox_left + 16;
				y = pick_id.bbox_bottom - 9;
				draw = false;
				frozen = true;
			} else {
				with (other) {
					minigame1vs3_points();
					minigame_finish();
					return;
				}
			}
		}
	
		minigame_time = 15;
		alarm_call(10, 1);
	} else {
		with (objPlayerBase) {
			if (pick_id == null) {
				with (other) {
					alarm_frames(6, 1);
					return;
				}
			}
		}
		
		with (points_teams[1][0]) {
			draw = true;
		}
		
		for (var i = 0; i < array_length(points_teams[0]); i++) {
			with (points_teams[0][i]) {
				if (pick_id != 0) {
					x = pick_id.bbox_right - 16;
					y = pick_id.bbox_bottom - 9;
				} else {
					x = xpos;
					y = ypos;
				}
			}
		}
		
		for (var i = 0; i < array_length(points_teams[0]); i++) {
			var player = points_teams[0][i];
			
			if (player.pick_id == points_teams[1][0].pick_id) {
				minigame1vs3_points();
				minigame_finish();
				return;
			}
		}
		
		if (current_round < 3) {
			alarm_call(7, 5);
		} else {
			minigame4vs_points(points_teams[1][0].network_id);
			minigame_finish();
			return;
		}
	}
	
	lights = true;
	hider ^= true;
});

alarm_create(7, function() {
	for (var i = 0; i < array_length(points_teams[0]); i++) {
		var player = points_teams[0][i];
		
		if (player.pick_id != 0) {
			player.pick_id.image_index = 1;
		}
	}
	
	with (objPlayerBase) {
		x = xpos;
		y = ypos;
		frozen = true;
		pick_id = null;
	}
	
	lights = false;
	current_round++;
	alarm_call(4, 1);
});