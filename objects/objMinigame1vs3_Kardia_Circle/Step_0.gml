if (!objMinigameController.kardia_start || objMinigameController.info.is_finished) {
	exit;
}

var player = minigame1vs3_team(reference);
var move_angle = (global.actions.right.held(player.network_id) - global.actions.left.held(player.network_id));

if (move_angle != 0) {
	circle_move(move_angle);
}

if (--explosion_cooldown > 0) {
	exit;
}

with (objMinigame1vs3_Kardia_Cherry) {
	if (circle_reference == other.reference && image_index != c_white) {
		image_blend = c_white;
	}
}

if (global.actions.shoot.pressed(player.network_id)) {
	circle_shoot();
}