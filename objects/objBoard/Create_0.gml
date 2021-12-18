global.board_started = false;
global.path_current = path_begin;
global.path_number = 0;
global.path_direction = 1;
global.dice_roll = -1;
global.player_turn = 1;
global.choosing_shine = false;

//Temp
temp = false;

for (var i = 1; i <= 4; i++) {
	var info = instance_create_layer(0, -32, "Managers", objPlayerInfo);
	info.player_info = new PlayerBoard(i, i);
}
//Temp