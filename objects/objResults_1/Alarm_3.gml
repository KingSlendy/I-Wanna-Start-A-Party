if (bonus_round == 3) {
	global.give_bonus_shines = false;
	alarm[0] = 1;
	exit;
}

var bonus = bonus_candidates[bonus_round];
var b = instance_create_layer(400, 400, "Actors", objResultsBonusShine);
b.bonus = bonus;
bonus_round++;

//if (global.player_id == 1) {
//	start_dialogue([
//		new Message()
//	]);
//}

