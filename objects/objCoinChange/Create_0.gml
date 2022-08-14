event_inherited();

enum CoinChangeType {
	None,
	Gain,
	Lose,
	Spend,
	Results,
	Exchange
}

animation_type = CoinChangeType.None;

alarm_create(function() {
	if (amount == 0) {
		alarm_frames(11, 20);
		return;
	}

	focus_player = focus_player_by_id(network_id);
	var c = instance_create_layer(focus_player.x, focus_player.y - 100, "Actors", objCoin);
	c.focus_player = focus_player;
	c.vspeed = 6;

	if (++animation_amount == abs(amount)) {
		alarm_frames(11, 20);
		return;
	}

	alarm_call(CoinChangeType.Gain, max(0.06, 0.15 - abs(amount) * 0.005));
});

alarm_create(function() {
	if (amount == 0) {
		alarm_frames(11, 20);
		return;
	}

	focus_player = focus_player_by_id(network_id);
	var c = instance_create_layer(focus_player.x, focus_player.y, "Actors", objCoin);
	c.focus_player = focus_player;
	c.vspeed = -8;
	audio_play_sound(sndCoinLose, 0, false);

	if (++animation_amount == abs(amount)) {
		alarm_frames(11, 20);
		return;
	}

	alarm_call(CoinChangeType.Lose, max(0.06, 0.15 - abs(amount) * 0.005));
});

alarm_create(function() {
	alarm_frames(11, 1);
});

alarm_create(function() {
	if (amount == 0) {
		alarm_frames(11, 20);
		return;
	}

	focus_player = focus_player_by_id(network_id);
	var c = instance_create_layer(focus_player.x - 100, focus_player.y, "Actors", objCoin);
	c.focus_player = focus_player;
	c.hspeed = 6;

	if (++animation_amount == abs(amount)) {
		alarm_frames(11, 20);
		return;
	}

	alarm_call(4, max(0.06, 0.15 - abs(amount) * 0.005));
});

alarm_create(11, function() {
	animation_state = 1;
	player_info.coins += amount;
	player_info.coins = clamp(player_info.coins, 0, 999);

	if (player_info.network_id == global.player_id) {
		if (player_info.coins >= 100) {
			gain_trophy(5);
		}

		if (player_info.coins <= 0) {
			gain_trophy(6);
		}
	}

	calculate_player_place();
});