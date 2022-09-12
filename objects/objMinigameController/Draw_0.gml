var draw_player = function(player) {
	with (player) {
		if (draw && !lost) {
			switch (room) {
				case rMinigame4vs_Magic:
					draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, player_color_by_turn(player_info_by_id(network_id).turn), image_alpha);
					break;
				
				case rMinigame4vs_Rocket:
					draw_sprite_ext(sprPlayerRocket_Flame, 0, x + 34 * dcos(image_angle + 270), y - 34 * dsin(image_angle + 270), spd / 12, spd / 12, (image_angle + 360 + 180) % 360, c_white, 1);
					draw_sprite_ext(sprPlayerRocket, 0, x, y, 1, 1, image_angle, c_white, image_alpha);
					draw_sprite_ext(sprite_index, 0, x, y, 1, 1, image_angle, c_white, image_alpha);
					break;
					
				case rMinigame4vs_Bubble:
					draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
					draw_sprite(sprPlayerBubble, 0, x, y);
					break;
					
				case rMinigame4vs_Idol:
					draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, player_color_by_turn(player_info_by_id(network_id).turn), image_alpha);
					break;
					
				default:
					event_perform(ev_draw, 0);
					break;
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