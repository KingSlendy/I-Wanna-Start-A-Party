depth = layer_get_depth("Tiles") - 1;
target_x = x;
target_y = y;
target_spd = 10;
target_switched = false;
coins = 0;
total = 0;
selectable = false;
selected = -1;

function switch_target(new_x = null, new_y = null) {
	if (new_x != null) {
		target_x = new_x;
	}
	
	if (new_y != null) {
		target_y = new_y;
	}
	
	target_switched = true;
}

alarms_init(4);

alarm_create(function() {
	next_seed_inline();
	coins = irandom(10);
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
	minigame4vs_points(selected, 1);
	alarm_call(3, 0.25);
});