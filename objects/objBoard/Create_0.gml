global.board_started = false;
global.path_direction = 1;
global.dice_roll = 0;
global.player_turn = 1;
global.choosing_shine = false;
global.can_open_map = false;
global.choice_selected = -1;

for (var i = 1; i <= 4; i++) {
	var info = instance_create_layer(0, -32, "Managers", objPlayerInfo);
	info.player_info = new PlayerBoard(i, i);
}

//Temp
temp = false;
//Temp