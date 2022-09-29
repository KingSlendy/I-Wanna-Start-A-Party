event_inherited();
network_mode = PlayerDataMode.Hammer;
max_spd = 5;
hspd = 0;
vspd = 0;
can_hit = true;

alarm_create(0, function() {
	image_index = 0;
});

alarm_create(1, function() {
	can_hit = true;
});