draw_self();

if (idol == -1) {
	exit;
}

var color = c_white;

if (hit) {
	color = c_red;
} else if (portion != height) {
	color = c_gray;
}

draw_sprite_part_ext(sprMinigame4vs_Idol_Idol, idol, 0, 0, width, portion, x + 22, round(remap(portion, 0, height, y + 30, y - 30)), 1, 1, color, 1);