with (objPlayerBase) {
	change_to_object(objPlayerBoard);
}

global.board_turn = 1;
global.player_turn = 1;
global.dice_roll = 0;
global.choosing_shine = false;
global.choice_selected = -1;

for (var i = 1; i <= global.player_max; i++) {
	var info = instance_create_layer(0, -32, "Managers", objPlayerInfo);
	info.player_info = new PlayerBoard(i, focus_player_by_id(i).network_name, i);
}

//Temp
temp = false;
//Temp

alarm[0] = 1;