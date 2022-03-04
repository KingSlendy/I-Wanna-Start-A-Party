depth = -10010;
state = 0;
alpha = 0;
zoom = false;
player_colors = [];
minigame_total = 5;
minigame_list = [
	global.minigames[$ "2vs2"][0],
	global.minigames[$ "2vs2"][0],
	global.minigames[$ "2vs2"][0],
	global.minigames[$ "2vs2"][0],
	global.minigames[$ "2vs2"][0],
];

minigames_alpha = 0;
minigames_width = 300;
minigames_height = 40;
minigames_timer = 3;
minigames_chosen = irandom(minigame_total - 1);

if (is_local_turn()) {
	global.choice_selected = irandom(minigame_total - 1);
}

objBoard.alarm[11] = 0;