shake = lerp(shake, 0, 0.1);

if (shake > 0.1) {
	camera_set_view_pos(view_camera[0], irandom_range(-shake, shake), irandom_range(-shake, shake));
}

if (info.is_finished) {
	exit;
}

if (minigame_lost_all()) {
	minigame_lost_points();
	minigame_finish();
}