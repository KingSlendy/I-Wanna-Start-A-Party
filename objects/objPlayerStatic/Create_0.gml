event_inherited();
network_mode = PlayerDataMode.Basic;
xscale = 1;
orientation = 1;
spinning = false;
spin_index = 0;

alarm_create(0, function() {
	sprite_index = skin[$ "Idle"];
});

alarm_create(1, function() {
	spinning = false;
})

alarm_frames(0, 1);