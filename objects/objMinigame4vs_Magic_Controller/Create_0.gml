with (objPlayerBase) {
	change_to_object(objPlayerHand);
}

event_inherited();

player_check = objPlayerHand;
minigame_split = true;
minigame_time = 40;
minigame_time_valign = fa_top;
minigame_time_end = function() {
	//with (objPlayerBase) {
	//	if (lost) {
	//		continue;
	//	}
		
	//	minigame_4vs_points(objMinigameController.info, network_id);
	//}
	
	//minigame_finish();
}

state = 0;
item_order = array_shuffle(array_sequence(0, sprite_get_number(sprMinigame4vs_Magic_Items)));
