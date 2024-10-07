draw_self();
var picture_x = x + picture_border;
var picture_y = y + picture_border;
draw_set_color(c_white);

for (var r = 0; r < picture_divisions; r++) {
	for (var c = 0; c < picture_divisions; c++) {
		var section_x = picture_x + picture_divisions_length * c;
		var section_y = picture_y + picture_divisions_length * r;
		var section_current = picture_sequence[r][c][picture_current[r][c]];
		
		if (picture_locked[r][c] || !picture_rotate) {
			draw_sprite_part_ext(pictures[section_current], 0, picture_divisions_length * c, picture_divisions_length * r, picture_divisions_length, picture_divisions_length, section_x, section_y, 1, 1, (picture_locked[r][c]) ? c_white : c_gray, 1);
		} else {
			var section_next = picture_sequence[r][c][(picture_current[r][c] + 1 + array_length(pictures)) % array_length(pictures)];
			draw_sprite_part_ext(pictures[section_current], 0, picture_divisions_length * c, picture_divisions_length * r, picture_divisions_length, picture_divisions_length, section_x, section_y, picture_travel, 1, c_gray, 1);
			draw_sprite_part_ext(pictures[section_next], 0, picture_divisions_length * c, picture_divisions_length * r, picture_divisions_length, picture_divisions_length, section_x + picture_divisions_length * picture_travel, section_y, 1 - picture_travel, 1, c_gray, 1);
		}
		
		var player = null;
		var pressed = false;
		
		if (x < 400) {
			player = minigame1vs3_solo();
			pressed = global.actions.jump.pressed(player.network_id);
		} else {
			for (var i = 0; i < minigame1vs3_team_length(); i++) {
				player = minigame1vs3_team(i);
				
				if (global.actions.jump.pressed(player.network_id)) {
					pressed = true;
					break;
				}
			}
		}
		
		if (is_player_local(player.network_id) && !picture_divisions_fade && pressed && point_in_rectangle(player.x, player.y, section_x, section_y, section_x + (picture_divisions_length - 1), section_y + (picture_divisions_length - 1)) ) {
			picture_section_toggle(r, c, !picture_locked[r][c], picture_current[r][c]);
		}
		
		draw_set_alpha(picture_divisions_alpha);
		draw_rectangle(section_x, section_y, section_x + (picture_divisions_length - 1), section_y + (picture_divisions_length - 1), true);
		draw_rectangle(section_x + 1, section_y + 1, section_x + (picture_divisions_length - 2), section_y + (picture_divisions_length - 2), true);
		draw_set_alpha(1);
	}
}

draw_set_alpha(picture_divisions_cover_alpha);
draw_set_color(c_black);
draw_rectangle(picture_x, picture_y, picture_x + (picture_length - 1), picture_y + (picture_length - 1), false);
draw_set_alpha(1);