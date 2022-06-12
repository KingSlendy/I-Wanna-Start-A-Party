info = global.minigame_info;
shuffle_seed_inline();
reset_seed_inline();

with (objPlayerBase) {
	frozen = true;
	lost = false;
}

minigame_start = minigame_4vs_start;
minigame_camera = CameraMode.Static;
minigame_time = -1;
minigame_time_halign = fa_center;
minigame_time_valign = fa_bottom;
minigame_time_end = minigame_finish;
action_end = function() {}
var name = room_get_name(room);
music = asset_get_index("bgm" + string_copy(name, 2, string_length(name) - 1));
started = false;
announcer_started = false;
alpha = 1;
finished = false;
announcer_finished = false;
cleaned = false;
points_draw = false;
points_number = true;
points_teams = [];
player_check = objPlayerBase;

function back_to_board() {
	event_perform(ev_cleanup, 0);
	
	if (!info.is_practice) {
		if (++global.board_turn > global.max_board_turns) {
			board_finish();
			return;	
		}
		
		room_goto(info.previous_board);
	
		with (objPlayerBase) {
			change_to_object(objPlayerBase);
		}
	} else {
		room_goto(rMinigameOverview);
	
		with (objPlayerBase) {
			change_to_object(objPlayerBase);
		}
		
		return;
	}
	
	with (objPlayerInfo) {
		target_draw_x = main_draw_x;
		target_draw_y = main_draw_y;
		draw_x = target_draw_x;
		draw_y = target_draw_y;
	}
}
