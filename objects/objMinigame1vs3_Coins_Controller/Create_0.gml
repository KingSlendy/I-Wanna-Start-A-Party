event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_shoot = false;
		hittable = true;
	}
}

minigame_time = 30;
minigame_time_end = function() {
	if (trophy_hit && focus_player_by_id(global.player_id).x > 192) {
		gain_trophy(15);
	}
	
	minigame_finish();
}

action_end = function() {
	alarm_stop(4);
	alarm_stop(5);
}

points_draw = true;
player_check = objPlayerPlatformer;

coin_count = 0;
spike_count = 0;

trophy_hit = true;

alarm_override(1, function() {
	alarm_inherited(1);
	alarm_frames(4, 1);
	alarm_frames(5, 1);
});

alarm_create(4, function() {
	next_seed_inline();

	if (coin_count++ % 2 == 0) {
		var c = instance_create_layer(496, 256, "Collectables", objMinigame1vs3_Coins_Coin);
	} else {
		var c = instance_create_layer(720, 256, "Collectables", objMinigame1vs3_Coins_Coin);
	}

	c.hspeed = choose(-1, 1);

	alarm_call(4, 0.8);
});

alarm_create(5, function() {
	var s = instance_create_layer(48, 256, "Collectables", objMinigame1vs3_Coins_Spike);
	s.count = spike_count++;
});