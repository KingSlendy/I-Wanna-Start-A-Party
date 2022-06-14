with (objPlayerBase) {
	change_to_object(objPlayerHand);
}

event_inherited();

minigame_camera = CameraMode.Split4;
minigame_time_valign = fa_top;
minigame_time_end = function() {
	instance_create_layer(0, 0, "Managers", objMinigame4vs_Magic_Checker);
}

player_check = objPlayerHand;

state = 0;
item_order = array_sequence(0, sprite_get_number(sprMinigame4vs_Magic_Items));
array_shuffle(item_order);
