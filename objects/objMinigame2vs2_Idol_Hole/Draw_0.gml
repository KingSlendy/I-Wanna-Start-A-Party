draw_self();

if (idol == -1) {
	exit;
}

var color = c_white;

if (hit != 0) {
	color = player_color_by_turn(player_info_by_id(hit).turn);
} else if (portion != height) {
	color = c_gray;
}

draw_sprite_part_ext(sprMinigame2vs2_Idol_Idol, idol, 0, 0, width, portion, x + 22, round(remap(portion, 0, height, y + 30, y - 30)), 1, 1, color, 1);