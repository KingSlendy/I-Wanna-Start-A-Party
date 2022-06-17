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
		}
	}
}

if (skin_selected != skin_target_selected) {
	skin_x = lerp(skin_x, skin_target_x, 0.4);
	
	if (point_distance(skin_x, 0, skin_target_x, 0) < 1.5) {
		skin_x = 400;
		skin_target_x = skin_x;
		skin_selected = skin_target_selected;
	}
}

if (!fade_start && skin_selected == skin_target_selected && buying == -1) {
	var scroll_h = (sync_actions("right", 1) - sync_actions("left", 1));
	
	if (scroll_h != 0) {
		skin_target_x -= 150 * scroll_h;
		skin_target_selected = (skin_selected + array_length(global.skins) + scroll_h) % array_length(global.skins);
		dir = scroll_h * -1;
		audio_play_sound(global.sound_cursor_move, 0, false);
		exit;
	}
	
	if (sync_actions("jump", 1)) {
		if (!array_contains(global.collected_skins, skin_selected) && global.skins[skin_selected].price <= global.collected_coins) {
			buying = global.skins[skin_selected].price;
			alarm[0] = 1;
			audio_play_sound(global.sound_cursor_select2, 0, false);
			exit;
		}
	}
	
	if (sync_actions("shoot", 1)) {
		back = true;
		fade_start = true;
		music_fade();
		audio_play_sound(global.sound_cursor_back, 0, false);
	}
}

with (objNothing) {
	if (y >= 540) {
		if (global.player_id == 1) {
			global.skins[other.skin_selected].price--;
		
			if (global.skins[other.skin_selected].price == 0) {
				array_push(global.collected_skins, other.skin_selected);
				save_file();
				other.buying = -1;
			}
		}
		
		audio_play_sound(sndCoinGet, 0, false);
		instance_destroy();
	}
}
