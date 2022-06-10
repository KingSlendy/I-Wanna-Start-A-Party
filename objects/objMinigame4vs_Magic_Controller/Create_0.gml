with (objPlayerBase) {
	change_to_object(objPlayerHand);
}

event_inherited();

player_check = objPlayerHand;
minigame_split = true;
//minigame_time = 40;
minigame_time_valign = fa_top;
minigame_time_end = function() {
	instance_create_layer(0, 0, "Managers", objMinigame4vs_Magic_Checker);
	
	//with (objPlayerBase) {
	//	if (lost) {
	//		continue;
	//	}
		
	//	minigame4vs_points(objMinigameController.info, network_id);
	//}
	
	//minigame_finish();
}

state = 0;
item_order = array_sequence(0, sprite_get_number(sprMinigame4vs_Magic_Items));
array_shuffle(item_order);
mimic_order = [];
array_copy(mimic_order, 0, item_order, 10, array_length(item_order) - 10);
array_shuffle(mimic_order);
