event_inherited();
network_mode = PlayerDataMode.Rocket;
friction = 0.001;
max_spd = 8;
shoot_delay = 0;

alarm_create(0, function() {
	image_alpha = 1;
});