depth = layer_get_depth("Tiles") - 1;
target_x = x;
target_y = y;
target_spd = 10;
angle = 0;
target_angle = angle;
target_angle_spd = 0;
target_switched = false;
coins = 0;
total = 0;
selectable = false;
selected = -1;

function switch_target(new_x = null, new_y = null, new_angle = null) {
	if (new_x != null) {
		target_x = new_x;
	}
	
	if (new_y != null) {
		target_y = new_y;
	}
	
	if (new_angle != null) {
		target_angle = new_angle;
	}
	
	angle = target_angle - 180;
	target_angle_spd = abs(angle - target_angle) / (abs(x - target_x) / (target_spd * DELTA));
	target_switched = true;
}

alarms_init(4);

alarm_create(function() {
	next_seed_inline();
	
	switch (objMinigameController.chest_round - 1) {
		case 0: coins = n; break;	
		case 1: coins = (n >= 2) ? n : 0 break;
		case 2: coins = (n == 3) ? 5 : 0 break;
	}
	
	if (trial_is_title(STINGY_CHESTS)) {
		coins = (n == 0);
	}
	
	image_index = 1;
	alarm_call(1, 0.5);
});

alarm_create(function() {
	if (++total > coins) {
		total = 0;
		return;
	}

	instance_create_layer(x, -20, "Actors", objMinigame4vs_Chests_CoinAppear);
	alarm_call(1, 0.25);
});

alarm_create(function() {});

alarm_create(function() {
	if (++total > coins) {
		total = 0;
		return;
	}

	instance_create_layer(x, y - 20, "Actors", objMinigame4vs_Chests_CoinDisappear);
	
	if (selected != -1) {
		minigame4vs_points(selected, 1);
	}
	
	alarm_call(3, 0.25);
});