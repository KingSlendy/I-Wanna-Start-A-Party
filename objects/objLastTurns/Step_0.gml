if (current_follow != null) {
	objCamera.target_follow = current_follow;
}

if (state == 0) {
	fade_alpha += 0.03;
	
	if (fade_alpha >= 1) {
		global.player_turn = previous_turn;
		
		for (var i = 1; i <= global.player_max; i++) {
			var player = focus_player_by_turn(i);
			var prev_pos = prev_player_positions[i - 1];
			player.x = prev_pos.x;
			player.y = prev_pos.y;
		}
		
		with (objPlayerInfo) {
			draw_x = main_draw_x;
			draw_y = main_draw_y;
			target_draw_x = draw_x;
			target_draw_y = draw_y;
		}
		
		switch (event) {
			case 0:
				with (objSpaces) {
					if (image_index == SpaceType.Red) {
						image_index = SpaceType.TheGuy;
					}
				}
				break;
				
			case 1:
				with (objSpaces) {
					if (image_index == SpaceType.Red) {
						image_index = SpaceType.ChanceTime;
					}
				}
				break;
				
			case 2:
				with (objSpaces) {
					if (image_index == SpaceType.Red) {
						image_index = SpaceType.Item;
					}
				}
				break;
				
			case 3:
				with (objSpaces) {
					if (image_index == SpaceType.Blue && !space_shine) {
						image_index = SpaceType.Red;
					}
				}
				break;
				
			case 4:
				with (objSpaces) {
					if (image_index == SpaceType.Red) {
						image_index = SpaceType.Surprise;
					}
				}
				break;
		}
		if room != rBoardFASF
		{
			music_resume();
			audio_sound_gain(global.music_current, 1, 1000);
		}
		else
		{
			// FASF event
			board_fasf_play_music();
			board_fasf_set_event(true);
		}
		
		instance_destroy(objLastTurnsChoice);
		focus_player = null;
		fade_alpha = 1;
		state = 1;
	}
} else if (state == 1) {
	fade_alpha -= 0.03;
	
	if (fade_alpha <= 0) {
		instance_destroy();
	}
}