with (objPlayerBase) {
	change_to_object(objPlayerBoard);
}

global.board_started = false;
global.dice_roll = 0;
global.player_turn = 1;
global.choosing_shine = false;
global.can_open_map = false;
global.choice_selected = -1;

for (var i = 1; i <= 4; i++) {
	var info = instance_create_layer(0, -32, "Managers", objPlayerInfo);
	var name;
	
	if (i == global.player_id) {
		name = global.player_name;
	} else {
		try {
			name = focus_player(i).network_name;
		} catch (_) {
			name = "???";
		}
	}
	
	info.player_info = new PlayerBoard(i, name, i);
}

//Temp
temp = false;
//Temp