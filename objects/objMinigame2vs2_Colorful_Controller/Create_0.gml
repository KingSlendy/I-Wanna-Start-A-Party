with (objPlayerBase) {
	change_to_object(objPlayerStatic);
}

event_inherited();

minigame_start = minigame2vs2_start;
player_check = objPlayerStatic;

next_seed_inline();
round_seed = [];

for (var i = 0; i < 4; i++) {
	round_seed[i][0] = irandom(9999999);
	round_seed[i][1] = irandom(9999999);
}

trophy_found = true;