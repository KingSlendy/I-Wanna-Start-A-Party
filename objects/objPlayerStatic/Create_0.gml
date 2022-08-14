event_inherited();
network_mode = PlayerDataMode.Basic;

alarm_create(0, function() {
	sprite_index = skin[$ "Idle"];
});

alarm_frames(0, 1);