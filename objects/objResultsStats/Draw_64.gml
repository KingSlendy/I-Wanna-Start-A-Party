if (sprite != null) {
	draw_sprite(sprite, 0, 0, 0);
	draw_set_alpha(fade_alpha);
	draw_set_color(c_black);
	draw_rectangle(0, 0, 800, 608, false);
	draw_set_font(fntFilesButtons);
	draw_set_alpha(1);
}

draw_set_font(fntFilesButtons);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 0; i < array_length(stats_bonuses); i++) {
	var draw_x = stats_x + i * 80;
	var draw_y = 80;
	
	if (draw_x >= 320) {
		var draw_alpha = 1;
	} else {
		var dist = point_distance(320, 0, draw_x, 0);
		var draw_alpha = (dist < 80) ? remap(dist, 0, 80, 1, 0) : 0;
	}
	
	var bonus = global.bonus_shines[$ stats_bonuses[i]];
	draw_set_alpha(draw_alpha);
	draw_sprite_stretched(sprResultsMark, 0, draw_x, draw_y, 64, 64);
	var xoff = sprite_get_xoffset(bonus.sprite);
	var yoff = sprite_get_yoffset(bonus.sprite);
	var w = sprite_get_width(bonus.sprite);
	var h = sprite_get_height(bonus.sprite);
	sprite_set_offset(bonus.sprite, w / 2, h / 2);
	draw_sprite_stretched(bonus.sprite, bonus.index, draw_x + 8, draw_y + 8, 48, 48);
	sprite_set_offset(bonus.sprite, xoff, yoff);
	draw_sprite_stretched(sprResultsMarkStats, 0, draw_x, draw_y + 70, 64, 390);
	
	for (var j = 1; j <= global.player_max; j++) {
		var player_info, player_id;
	
		with (objPlayerInfo) {
			if (order == j) {
				player_info = id;
				player_id = self.player_info.network_id;
				break;
			}
		}
	
		draw_text_color_outline(draw_x + 48 / 2 + 10, player_info.draw_y + player_info.draw_h / 2, bonus.scores[player_id - 1], #FFD700, #FFD700, c_yellow, c_yellow, draw_alpha, c_black);
	}
	
	draw_set_alpha(1);
}

draw_set_valign(fa_top);
draw_set_halign(fa_left);

if (show_inputs) {
	draw_set_color(c_white);
	draw_text_outline(50, 85, "Turns: " + string(global.max_board_turns), c_black);
	
	if (stats_page > 0){
		draw_sprite_ext(bind_to_key(global.actions.left.button), 0, 340, 570, 0.5, 0.5, 0, c_white, 1);
	}
	
	if (stats_page < stats_total_page) {
		draw_sprite_ext(bind_to_key(global.actions.right.button), 0, 760, 570, 0.5, 0.5, 0, c_white, 1);
	}
	
	var text = new Text(fntDialogue, draw_action(global.actions.jump) + ": Proceed");
	text.draw(50, 565);
}
