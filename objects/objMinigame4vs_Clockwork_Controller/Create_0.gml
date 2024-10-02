event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		target_numbers = null;
		target_delay = 0;
	}
}

minigame_time_end = function() {
	with (objMinigame4vs_Clockwork_ClockAnalog) {
		check_target_time = false;
		clock_analog_random_time();
	}
}

minigame_camera = CameraMode.Split4;
points_draw = true;

player_type = objPlayerHand;

state = 0;

alarm_override(0, function() {
	if (state < 4) {
		if (state == 0) {
			audio_play_sound(sndMinigame4vs_Clockwork_AnalogTick, 0, false);
		}
		
		with (objMinigame4vs_Clockwork_ClockAnalog) {
			clock_analog_tick_minutes(1);
		}
		
		alarm_call(0, 1);
	} else {
		with (objMinigame4vs_Clockwork_ClockAnalog) {
			hour = 0;
			minutes = 0;
		}
		
		alarm_inherited(0);
	}
	
	with (objMinigame4vs_Clockwork_ClockAnalog) {
		clock_analog_sync_digital();
	}
	
	state++;
});

alarm_override(1, function() {
	with (objMinigame4vs_Clockwork_ClockAnalog) {
		hour = 0;
		minutes = 0;
		clock_analog_random_time();
	} 
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);

		with (player) {
			if (!objMinigame4vs_Clockwork_ClockAnalog.check_target_time) {
				break;
			}
			
			with (objMinigame4vs_Clockwork_ClockDigital) {
				if (self.player.network_id != other.network_id) {
					continue;
				}
				
				var number_check_target = function() {
					for (var i = 0; i < number_digits; i++) {
						for (var j = 0; j < number_sections; j++) {
							if (other.target_numbers[i][j] != numbers[i][j]) {
								return { digit: i, section: j };
							}
						}
					}
					
					return null;
				}
				
				var number_follow_target = function(section, number_x, number_y) {
					image_index = section;
					x = number_x;
					y = number_y;
					var bbox = objMinigame4vs_Clockwork_ClockAnalog.sections_bbox[$ section];
					
					return {
						cx: x + bbox.left + (bbox.right - bbox.left) / 2,
						cy: y + bbox.top + (bbox.bottom - bbox.top) / 2
					}
				}
				
				var check_target = number_check_target();
				
				if (check_target == null) {
					break;
				}
				
				var follow_target = null;
				
				var temp_sprite_index = sprite_index;
				var temp_x = x;
				var temp_y = y;
					
				sprite_index = sprMinigame4vs_Clockwork_DigitalNumber;

				var number_x = x + border_length;
				var number_y = y + border_length;
				
				if (check_target.digit == 0) {
					follow_target = number_follow_target(check_target.section, number_x, number_y);
				}

				number_x += number_length + border_length;
				
				if (check_target.digit == 1) {
					follow_target = number_follow_target(check_target.section, number_x, number_y);
				}

				number_x += number_length + border_length + dots_length + border_length;
				
				if (check_target.digit == 2) {
					follow_target = number_follow_target(check_target.section, number_x, number_y);
				}

				number_x += number_length + border_length;
				
				if (check_target.digit == 3) {
					follow_target = number_follow_target(check_target.section, number_x, number_y);
				}
			
				if (follow_target != null) {
					with (other) {
						if (--target_delay >= 0) {
							break;
						}
						
						if (point_distance(x, y, follow_target.cx, follow_target.cy) > 4) {
							if (point_distance(x, 0, follow_target.cx, 0) >= 3) {
								var action_horizontal = (x > follow_target.cx) ? actions.left : actions.right;
								action_horizontal.press();
							}
							
							if (point_distance(0, y, 0, follow_target.cy) >= 3) {
								var action_vertical = (y > follow_target.cy) ? actions.up : actions.down;
								action_vertical.press();
							}
						} else {
							with (other) {
								clock_digital_section_toggle(check_target.digit, check_target.section);
							}
							
							target_delay = get_frames(random_range(0.5, 1.5));
						}
					}
				}
				
				sprite_index = temp_sprite_index;
				image_index = 0;
				x = temp_x;
				y = temp_y;
			}
		}
	}

	alarm_frames(11, 1);
});