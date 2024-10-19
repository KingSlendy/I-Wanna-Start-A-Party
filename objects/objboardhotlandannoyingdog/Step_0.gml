x = approach(x, target_x, 2);
y = approach(y, target_y, 2);

if (point_distance(x, y, target_x, target_y) < 1) {
	if (target_state == 0) {
		with (nearest) {
			losing = true;
			changing = true;
		}
		
		target_state = -1;
		audio_play_sound(sndShineGet, 0, false);
	} else if (target_state == 1) {
		instance_destroy();
	}
}