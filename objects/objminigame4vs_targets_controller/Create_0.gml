with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

event_inherited();

points_draw = true;
player_check = objPlayerPlatformer;

player_turn = 1;
player_bullets = array_create(global.player_max, 6);
next_turn = -1;
trophy_yellow = true;

function unfreeze_player() {
	var player = focus_player_by_turn(player_turn);
	player.frozen = false;
}

function reposition_player() {
	var player = focus_player_by_turn(player_turn);
	var prev_player = focus_player_by_turn(player_turn - 1);
	
	with (objPlayerReference) {
		if (reference == 1) {
			player.x = x + 17;
			player.y = y + 23;
			break;
		}
	}
	
	with (objPlayerReference) {
		if (reference == other.player_turn) {
			prev_player.x = x + 17;
			prev_player.y = y + 23;
			break;
		}
	}
	
	with (objMinigame4vs_Targets_Target) {
		restore_target();
	}
}