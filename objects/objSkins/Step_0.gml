timer++;
timer %= 1000;

if (fade_start) {
	if (!back) {
		if (get_player_count(objPlayerBase) == global.player_max) {
			fade_alpha -= 0.03;
			music_play(bgmSkins);
		
			if (fade_alpha <= 0) {
				fade_alpha = 0;
				fade_start = false;
			}
		}
	} else {
		fade_alpha += 0.03;
		
		if (fade_alpha >= 1) {
			fade_alpha = 1;
			fade_start = false;
			room_goto(rModes);
			exit;
		}
	}
}

if (skin_selected != skin_target_selected) {
	skin_x = lerp(skin_x, skin_target_x, (held_time == 25) ? 0.6 : 0.4);
	
	if (point_distance(skin_x, 0, skin_target_x, 0) < 1.5) {
		skin_x = 400;
		skin_target_x = skin_x;
		skin_selected = skin_target_selected;
	}
}

if (!fade_start && skin_selected == skin_target_selected && buying == -1) {
	var held_h = (global.actions.right.held() - global.actions.left.held());
	
	if (held_h != 0) {
		held_time = min(++held_time, 25);
	} else {
		held_time = 0;
	}
	
	var scroll_h = (global.actions.right.pressed() - global.actions.left.pressed());
	
	if ((held_h != 0 && held_time == 25) || scroll_h != 0) {
		skin_target_x -= 150 * held_h;
		skin_target_selected = (skin_selected + array_length(global.skins) + held_h) % array_length(global.skins);
		dir = held_h * -1;
		audio_play_sound(global.sound_cursor_move, 0, false);
		exit;
	}
	
	if (global.actions.jump.pressed()) {
		if (!array_contains(global.collected_skins, skin_selected) && global.skins[skin_selected].price <= global.collected_coins) {
			if (global.skins[other.skin_selected].shop_price > 0) {
				buying = global.skins[skin_selected].price;
				alarm_frames(0, 1);
			} else {
				gain_skin(other.skin_selected);
			}
			
			audio_play_sound(global.sound_cursor_select2, 0, false);
			exit;
		}
	}
	
	if (global.actions.shoot.pressed()) {
		back = true;
		fade_start = true;
		music_fade();
		audio_play_sound(global.sound_cursor_back, 0, false);
	}
}

with (objNothing) {
	if (y >= 540) {
		if (global.player_id == 1) {
			global.skins[other.skin_selected].shop_price -= 10;
		
			if (global.skins[other.skin_selected].shop_price == 0) {
				gain_skin(other.skin_selected);
				other.buying = -1;
			}
		}
		
		audio_play_sound(sndCoinGet, 0, false);
		instance_destroy();
	}
}