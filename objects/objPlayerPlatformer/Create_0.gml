event_inherited();
network_mode = PlayerDataMode.All;
orientation = 1;
set_mask();
xscale = 1;
hspd = 0;
vspd = 0;
grav = 0;
max_hspd = 3;
max_vspd = 9;
grav_amount = 0.4;

jump_height = [8.5, 7];
jump_total = 2;
shoot_delay = 0;

on_block = false;
on_platform = false;
frozen = false;
enable_move = true;
enable_jump = true;
enable_shoot = true;

skin = get_skin();
reset_jumps();
