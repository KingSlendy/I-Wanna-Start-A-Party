points_draw = true;

if (points_draw) {
    var colors = info.player_colors;
    var score_x = [400 - 8 - 96, 400 + 8];
    var score_y = 96 * 2;
    var square_size = 96;
    var square_centered = square_size / 2;
    draw_sprite(sprMinigame2vs2_Soccer_UI_Team_Score, 0, 400 - 248, 96);
    
    for (var i = 0; i < array_length(points_teams); i++) {
        language_set_font(global.fntDialogue);
        var team = points_teams[i];
        var points = 0;
    
        for (var j = 0; j < array_length(team); j++) {
            var player = team[j];
            points += info.player_scores[player.network_id - 1].points;

            var player_x = (i == 0) ? 400 - 248 + 32 : 400 + 248 - 32 - square_size; // Split the teams
            var player_y = (j % 2 == 0) ? 96 + 32 : 96 + 288 - 32 - square_size;
            
            // Draw filled square
            draw_sprite_stretched_ext(sprMinigame2vs2_Soccer_UI_Point1x1, 0, player_x, player_y, square_size, square_size, color_character_background, 1);
            
            // Draw Player's kid // Player original size 32x32 - origin 17x23
            draw_sprite_ext(focus_info_by_id(player.network_id).player_idle_image, 0, player_x + square_centered + 3 - 2, player_y + square_size - 23 - 5 - 2, 3 * ((i == 0) ? 1 : -1), 3, 0, c_white, 1);
            
            //Draw outline
            draw_sprite_stretched_ext(sprMinigame2vs2_Soccer_UI_Outline, 0, player_x, player_y, square_size, square_size, colors[i], 1);
            
            //Draw an extra inner outline
            draw_sprite_stretched_ext(sprMinigame2vs2_Soccer_UI_Outline, 0, player_x + 2, player_y + 2, square_size - 4, square_size - 4, colors[i], 1);
        }
    
        draw_set_color(c_white);
        
        //Score
        if (points_number) {
            language_set_font(font_score);
			draw_set_color(color_number_background);
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_text(score_x[i] + square_centered + number_separation / 2, score_y + square_centered, "88");
            
			draw_set_alpha(goal_score_alpha[i]);
            draw_set_color(c_red);
			draw_text(score_x[i] + square_centered + number_separation / 2, score_y + square_centered, "0" + string(points));
			draw_set_alpha(1);
		}
    }
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
event_inherited();
points_draw = false;