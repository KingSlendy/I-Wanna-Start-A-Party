if (sprite != null) {
	draw_sprite(sprite, 0, 0, 0);
	draw_set_alpha(fade_alpha);
	draw_set_color(c_black);
	draw_rectangle(0, 0, 800, 608, false);
	draw_set_font(fntFilesButtons);
	draw_set_alpha(1);
}

draw_set_font(fntTrophies);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 0; i < array_length(global.bonus_shines); i++) {
	var draw_x = stats_x + i * 80;
	var draw_y = 80;
	
	if (draw_x >= 320) {
		var draw_alpha = 1;
	} else {
		var dist = point_distance(320, 0, draw_x, 0);
		var draw_alpha = (dist < 80) ? remap(dist, 0, 80, 1, 0) : 0;
	}
	
	var bonus = global.bonus_shines[i];
	draw_set_alpha(draw_alpha);
	draw_sprite_stretched(sprResultsMark, 0, draw_x, draw_y, 64, 64);
	draw_sprite_stretched(sprResultsBonus, bonus.index, draw_x + 8, draw_y + 8, 48, 48);
	draw_sprite_stretched(sprResultsMarkStats, 0, draw_x, draw_y + 70, 64, 390);
	
	for (var j = 1; j <= global.player_max; j++) {
		var player_info;
	
		with (objPlayerInfo) {
			if (order == j) {
				player_info = id;
				break;
			}
		}
	
		var text = bonus.scores[player_info.player_info.turn - 1];
		var is_max = array_contains(bonus.max_players(), player_info.player_info.turn);
		var color1 = (is_max) ? #005D00 : #FFD700;
		var color2 = (is_max) ? c_lime : c_yellow;
		var scale = (string_length(text) < 3) ? 1 : 0.9;
		draw_text_transformed_color_outline(draw_x + 48 / 2 + 8, player_info.draw_y + player_info.draw_h / 2, text, scale, scale, 0, color1, color1, color2, color2, draw_alpha, c_black);
	}
	
	draw_set_alpha(1);
}

draw_set_valign(fa_top);
draw_set_halign(fa_left);

if (show_inputs) {
	draw_set_color(c_white);
	draw_text_outline(50, 85, "Turns: " + string(global.max_board_turns), c_black);
	
	if (stats_page > 0){
		draw_sprite_ext(global.actions.left.bind(), 0, 340, 570, 0.5, 0.5, 0, c_white, 1);
	}
	
	if (stats_page < stats_total_page) {
		draw_sprite_ext(global.actions.right.bind(), 0, 760, 570, 0.5, 0.5, 0, c_white, 1);
	}
	
	var text = new Text(fntDialogue, draw_action(global.actions.jump) + ": {COLOR,00FFFFF}Proceed");
	text.draw(50, 565);
}