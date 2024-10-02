event_inherited();
network_mode = PlayerDataMode.Static;
xscale = 1;
orientation = 1;
spinning = false;
spin_index = 0;
stunned = false;

alarm_create(0, function() {
	sprite_index = skin[$ "Idle"];
});

alarm_create(1, function() {
	sprite_index = skin[$ "Idle"];
	xscale = 1;
	spinning = false;
	spin_index = 0;
})

alarm_create(2, function() {
	stunned = false;
});

alarm_frames(0, 1);