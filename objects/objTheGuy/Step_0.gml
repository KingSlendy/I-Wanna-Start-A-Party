fade_alpha += 0.01;

if (fade_alpha >= 0.5) {
	fade_alpha = 0.5;
}

if (broken_sprite != noone) {
	broken_x += broken_hspd;
	broken_vspd += broken_grav;
	broken_y += broken_vspd;
}

if (options_fade == 0) {
	options_alpha += 0.04;
	
	if (options_alpha >= 1) {
		options_alpha = 1;
		alarm[3] = 1;
		options_fade = -1;
	}
} else if (options_fade == 1) {
	options_alpha -= 0.04;
	
	if (options_alpha <= 0) {
		options_alpha = 0;
		options_fade = -1;
		
		with (objPlayerBase) {
			change_to_object(objPlayerTheGuy);
		}
			
		var view_x = camera_get_view_x(view_camera[0]);
			
		with (objPlayerBase) {
			x = view_x - 600;
			y = camera_get_view_y(view_camera[0]) - 70;
		}
		
		var option = options[global.choice_selected];
		
		if (option.only_me) {
			var player = focused_player();
			player.x = view_x + 400;
		} else {
			for (var i = 1; i <= global.player_max; i++) {
				var player = focus_player_by_turn(i);
				player.x = view_x + 150 + 166 * (i - 1);
			}
		}
		
		alarm[4] = get_frames(2);
	}
}

if (!follow_player) {
	objCamera.target_follow = null;
}
