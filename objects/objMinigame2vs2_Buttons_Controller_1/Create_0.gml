with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

objPlayerBase.jump_total = -1;

event_inherited();

minigame_start = minigame_2vs2_start;
minigame_time = 40;
points_draw = true;
player_check = objPlayerPlatformer;
buttons_outside_list = [];
buttons_inside_list = [];

repeat (50) {
	array_push(buttons_outside_list, irandom(5));
	array_push(buttons_inside_list, irandom(5));
}

buttons_outside_current = 0;
buttons_inside_current = 0;

grid = mp_grid_create(0, 0, room_width / 32, room_height / 32, 32, 32);
mp_grid_add_instances(grid, objBlock, false);

with (objPlayerBase) {
	path = path_add();
	move_delay_timer = 0;
	jump_delay_timer = 0;
}
