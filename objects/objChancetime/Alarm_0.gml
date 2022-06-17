music_pause();
music_change(bgmChanceTime);

with (focus_player) {
	with (objPlayerReference) {
		if (reference == 1) {
			other.x = x + 17;
			other.y = y + 23;
		}
	}
}

current_follow = {x: focus_player.x, y: focus_player.y};

switch_camera_target(focus_player.x, focus_player.y).final_action = function() {
	objChanceTime.alarm[2] = get_frames(0.5);
}

started = true;