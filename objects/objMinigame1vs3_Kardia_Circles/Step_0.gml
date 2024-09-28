if (!objMinigameController.kardia_start || objMinigameController.info.is_finished) {
	exit;
}

var player = minigame1vs3_team(reference);
var move_angle = (global.actions.right.held(player.network_id) - global.actions.left.held(player.network_id));

if (move_angle != 0) {
	with (objMinigame1vs3_Kardia_Cherry) {
		if (circle_reference == other.reference) {
			circle_angle -= move_angle * 2;
		}
	}
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
	var temp_cherry_x = cherry_x;
	var temp_cherry_y = cherry_y;
	
	with (objMinigame1vs3_Kardia_Cherry) {
		if (circle_reference == other.reference && image_index != 0) {
			var explosion_amount = 4 + circle_reference;
			var angle = point_direction(x, y, temp_cherry_x, temp_cherry_y);
			
			for (var i = 0; i < 360; i += 360 / explosion_amount) {
				with (instance_create_layer(x, y, "Actors", objMinigame1vs3_Kardia_Cherry)) {
					explosion_angle = (i + angle + 360) % 360;
					explosion_distance = point_distance(x, y, temp_cherry_x, temp_cherry_y);
					image_index = other.image_index;
					speed = 7 + other.circle_reference;
					direction = explosion_angle;
				}
			}
			
			image_blend = c_gray;
		}
	}
	
	explosion_cooldown = get_frames(1.25);
	audio_play_sound(sndShoot, 0, false);
}