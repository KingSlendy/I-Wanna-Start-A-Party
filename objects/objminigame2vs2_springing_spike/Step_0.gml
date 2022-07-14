if (image_angle != 90) {
	exit;
}

if (abs(xstart - x) < 416) {
	var dir = (x < 400) ? 1 : -1;
	x += objMinigameController.points_teams[(x > 400)][0].lost * dir;
}