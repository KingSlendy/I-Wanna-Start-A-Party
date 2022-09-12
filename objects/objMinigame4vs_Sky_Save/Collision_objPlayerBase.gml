if (image_xscale < 3.5 || other.touched) {
	exit;
}

if (image_index == 0) {
	minigame4vs_points(other.network_id, 1);
} else if (minigame4vs_get_points(other.network_id) > 0) {
	minigame4vs_points(other.network_id, -1);
}

other.touched = true;
instance_destroy();