event_inherited();
network_mode = PlayerDataMode.Basic;
max_spd = 5;
hspd = 0;
vspd = 0;

alarm_create(0, function() {
	touched = false;
});