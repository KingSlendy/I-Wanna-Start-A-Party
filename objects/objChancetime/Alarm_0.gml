music_pause();
music_change(bgmChanceTime);

with (focus_player) {
	with (objPlayerReference) {
		if (reference == 1) {
			other.x = x;
			other.y = y;
		}
	}
}

current_follow = {x: focus_player.x, y: focus_player.y};

switch_camera_target(focus_player.x, focus_player.y).final_action = begin_chance_time;
started = true;