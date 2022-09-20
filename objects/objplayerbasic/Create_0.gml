event_inherited();
network_mode = PlayerDataMode.Basic;
xscale = 1;
orientation = 1;
hspd = 0;
vspd = 0;
grav = 0;
max_hspd = 3;
max_vspd = 9;
grav_amount = 0.4;

jump_height = [8.5, 7];
jump_total = 2;

on_block = false;
enable_jump = true;

alarm_create(0, function() {
	sprite_index = skin[$ "Idle"];
});

alarm_frames(0, 1);