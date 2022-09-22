event_inherited();

minigame_players = function() {
	with (objMinigame4vs_Magic_Items) {
		init_item();
	}
	
	with (objMinigame4vs_Magic_Curtain) {
		curtain_init();
	}
}

minigame_camera = CameraMode.Split4;
minigame_time_valign = fa_top;
minigame_time_end = function() {
	with (objMinigame4vs_Magic_Curtain) {
		alpha_target = 0;
		can_switch = false;
	}
	
	instance_create_layer(0, 0, "Managers", objMinigame4vs_Magic_Checker);
}

player_type = objPlayerHand;

state = 0;
item_order = array_sequence(0, sprite_get_number(sprMinigame4vs_Magic_Items));
array_shuffle(item_order);

alarm_override(0, function() {
	if (state++ == 1) {
		alarm_inherited(0);
	}
});