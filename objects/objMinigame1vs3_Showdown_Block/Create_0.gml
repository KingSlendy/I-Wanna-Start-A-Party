number = -1;
show = 0;
selecting = false;

alarms_init(1);

alarm_create(function() {
	var player = instance_place(x, y - 1, objPlayerBase);

	if (player != noone) {
		player_id = player.network_id;
	}
});

alarm_frames(0, 1);