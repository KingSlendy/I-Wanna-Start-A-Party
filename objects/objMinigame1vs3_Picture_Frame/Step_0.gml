if (picture_rotate) {
	picture_travel -= 0.1;
	
	if (picture_travel <= 0) {
		picture_travel = 1;
		
		for (var r = 0; r < picture_divisions; r++) {
			for (var c = 0; c < picture_divisions; c++) {
				if (!picture_locked[r][c]) {
					picture_current[r][c] = (picture_current[r][c] + 1 + array_length(pictures)) % array_length(pictures);
				}
			}
		}
		
		picture_rotate = false;
	}
}

if (!picture_divisions_fade) {
	var picture_matches = true;

	for (var r = 0; r < picture_divisions; r++) {
		for (var c = 0; c < picture_divisions; c++) {
			if (!picture_locked[r][c] || picture_sequence[r][c][picture_current[r][c]] != picture_chosen) {
				picture_matches = false;
			}
		}
	}

	if (picture_matches) {
		with (objMinigameController) {
			picture_chosen_alpha_target = 0;
		}
		
		with (objMinigame1vs3_Picture_Frame) {
			picture_divisions_fade = true;
			alarm_stop(0);
			alarm_call(1, 2);
		}
	
		objPlayerBase.frozen = true;
		audio_play_sound(sndMinigame1vs3_Picture_PictureConfirm, 0, false, 2);
		var network_id = (x < 400) ? minigame1vs3_solo().network_id : minigame1vs3_team(0).network_id;
		minigame4vs_points(network_id, 1);
		
		if (minigame4vs_get_points(network_id) >= 5) {
			with (objMinigame1vs3_Picture_Frame) {
				alarm_stop(1);
			}
			
			minigame_finish(true);
		}
	}
} else {
	picture_divisions_alpha -= 0.03;
}

if (picture_divisions_cover == 1) {
	picture_divisions_cover_alpha += 0.05;
	
	if (picture_divisions_cover_alpha >= 1) {
		picture_divisions_cover_alpha = 1;
		picture_divisions_cover = -1;
		picture_divisions_fade = false;
		picture_divisions_alpha = 1;
		
		with (objMinigameController) {
			picture_shuffle();
			picture_chosen_scale_target = 1;
		}
	}
} else if (picture_divisions_cover == -1) {
	picture_divisions_cover_alpha -= 0.05;
	
	if (picture_divisions_cover_alpha <= 0) {
		picture_divisions_cover_alpha = 0;
		picture_divisions_cover = 0;
		
		with (objMinigame1vs3_Picture_Frame) {
			alarm_call(0, 1);
		}
		
		objPlayerBase.frozen = false;
	}
}