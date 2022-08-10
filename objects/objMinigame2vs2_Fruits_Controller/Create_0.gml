with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_jump = false;
	enable_shoot = false;
	move_delay_timer = 0;
}

event_inherited();

minigame_start = minigame2vs2_start;
minigame_time = 30;
minigame_time_end = function() {
	alarm[4] = 0;
	minigame_finish();
	
	if (trophy_small > 0) {
		gain_trophy(25);
	}
	
	if (trophy_gordos > 0) {
		gain_trophy(26);
	}
}

points_draw = true;
player_check = objPlayerPlatformer;

for (var i = 1; i <= global.player_max; i++) {
	var player = focus_player_by_id(i);
	var b = instance_create_layer(player.x, player.y - 10, "Actors", objMinigame2vs2_Fruits_Basket);
	b.follow = player;
}

fruit_positions = [[], []];
fruit_types = [[], []];
current = 0;

repeat (2000) {
	array_push(fruit_positions[0], irandom_range(32, 320));
	array_push(fruit_positions[1], irandom_range(480, 768));
}

repeat (2000) {
	for (var i = 0; i < 2; i++) {
		array_push(fruit_types[i], choose(-2, 0, 1, 2));
	}
}

trophy_small = 5;
trophy_gordos = 3;