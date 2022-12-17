event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_shoot = false;
		jump_total = -1;
	}

	reset_round();
}

minigame_camera = CameraMode.Center;
minigame_time_valign = fa_top;
minigame_time_end = function() {
	objPlayerBase.frozen = true;
	
	if (hider) {
		with (minigame1vs3_solo()) {
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
	audio_play_sound(sndMinigame1vs3_Host_LightsOff, 0, false);
	alarm_call(6, 2);
}

action_end = function() {
	lights = true;
	audio_play_sound(sndMinigame1vs3_Host_LightsOn, 0, false);
}

player_type = objPlayerPlatformer;

reset_round = function() {
	with (objPlayerBase) {
		x = xstart;
		y = ystart;
		frozen = true;
		pick_id = null;
		choosed_door = null;
		touched_doors = [];
	}
	
	with (objMinigame1vs3_Host_Door) {
		pick_chance = random_range(0.25, 0.75);
		picked = false;
	}
}

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
	minigame1vs3_solo().frozen = false;
	minigame_time = 15;
	alarm_call(10, 1);
});

alarm_create(6, function() {	
	if (hider) {
		if (minigame1vs3_solo().pick_id == null) {
			alarm_frames(6, 1);
			return;
		}
		
		objPlayerBase.frozen = false;
		
		with (minigame1vs3_solo()) {
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
	
		minigame_time = 10;
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
		
		with (minigame1vs3_solo()) {
			draw = true;
		}
		
		for (var i = 0; i < minigame1vs3_team_length(); i++) {
			with (minigame1vs3_team(i)) {
				if (pick_id != 0) {
					x = pick_id.bbox_right - 16;
					y = pick_id.bbox_bottom - 9;
				} else {
					x = xstart;
					y = ystart;
				}
			}
		}
		
		for (var i = 0; i < minigame1vs3_team_length(); i++) {
			var player = minigame1vs3_team(i);
			
			if (player.pick_id == minigame1vs3_solo().pick_id) {
				minigame1vs3_points();
				minigame_finish();
				return;
			}
		}
		
		if (current_round < 3 && !trial_is_title(SLOW_POKE)) {
			alarm_call(7, 3);
		} else {
			minigame4vs_points(minigame1vs3_solo().network_id);
			minigame_finish();
			return;
		}
	}
	
	lights = true;
	hider ^= true;
	audio_play_sound(sndMinigame1vs3_Host_LightsOn, 0, false);
});

alarm_create(7, function() {
	for (var i = 0; i < minigame1vs3_team_length(); i++) {
		var player = minigame1vs3_team(i);
		
		if (player.pick_id != 0) {
			player.pick_id.image_index = 1;
		}
	}
	
	reset_round();
	
	lights = false;
	current_round++;
	audio_play_sound(sndMinigame1vs3_Host_LightsOff, 0, false);
	alarm_call(4, 1);
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			if (frozen) {
				break;
			}
			
			if (choosed_door == null) {
				if (minigame1vs3_is_solo(i)) {
					while (choosed_door == null) {
						var door = instance_nearest(x, y, objMinigame1vs3_Host_Door);
						
						if (door.image_index == 1 || array_contains(touched_doors, door) || (array_length(touched_doors) == 0 && 0.5 > random(1))) {
							instance_deactivate_object(door);
							continue;
						}
						
						choosed_door = door;
					}
					
					instance_activate_object(objMinigame1vs3_Host_Door);
				} else {
					touched_doors = minigame1vs3_solo().touched_doors;
					
					if (array_length(touched_doors) > 0) {
						array_shuffle(touched_doors);
						choosed_door = array_pop(touched_doors);
					}
				}
			}
			
			if (minigame1vs3_is_solo(i)) {
				if (choosed_door.picked) {
					choosed_door = null;
					break;
				}
			} else {
				if (choosed_door == pick_id) {
					break;
				}
			}
			
			var door_x = choosed_door.x + choosed_door.sprite_width / 2;
			var door_y = choosed_door.bbox_bottom - 9;
			var door_dist = point_distance(x, y, door_x, door_y);
			
			if (place_meeting(x, y, choosed_door) && door_dist <= 6) {
				if (minigame1vs3_is_solo(i)) {
					if (!choosed_door.picked && choosed_door.pick_chance > random(1)) {
						actions.up.press();
					}
					
					choosed_door.picked = true;
				} else {
					actions.up.press();
					break;
				}
			}
			
			mp_grid_path(other.grid, path, x, y, door_x, door_y, true);
			var dir = point_direction(x, y, path_get_point_x(path, 1), path_get_point_y(path, 1));
			
			if (abs(angle_difference(dir, 270)) >= 16) {
				var dist_to_up = abs(angle_difference(dir, 90));
				
				if (dist_to_up > 4) {
					var action = (dir >= 90 && dir <= 270) ? actions.left : actions.right;
					action.press();
				}
		
				if (--jump_delay_timer <= 0 && dist_to_up < 45) {
					actions.jump.hold(6);
					jump_delay_timer = 10;
				}
			}
		}
	}

	alarm_frames(11, 1);
});