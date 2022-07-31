var draw_player = function(player) {
	with (player) {
		if (draw && !lost) {
			if (room == rMinigame4vs_Rocket) {
				draw_sprite_ext(sprPlayerRocket_Flame, 0, x + 34 * dcos(image_angle + 270), y - 34 * dsin(image_angle + 270), spd / 12, spd / 12, (image_angle + 360 + 180) % 360, c_white, 1);
				draw_sprite_ext(sprPlayerRocket, 0, x, y, 1, 1, image_angle, c_white, image_alpha);
				draw_sprite_ext(sprite_index, 0, x, y, 1, 1, image_angle, c_white, image_alpha);
			} else {
				event_perform(ev_draw, 0);
			}
		}
	}
}

for (var i = 1; i <= global.player_max; i++) {
	if (i == global.player_id) {
		continue;
	}
		
	draw_player(focus_player_by_id(i));
}
	
draw_player(focus_player_by_id());