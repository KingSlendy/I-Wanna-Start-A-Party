with (objPlayerBase) {
	change_to_object(objPlayerStatic);
}

event_inherited();

minigame_start = minigame1vs3_start;
minigame_camera = CameraMode.Split4;
action_end = function() {
	solo_action = null;
	team_action = null;
	alarm_stop(4);
	alarm_stop(5);
}

player_check = objPlayerStatic;

press_actions = [
	"right",
	"up",
	"left",
	"down",
	"jump",
	"shoot"
];

solo_action = null;
team_action = null;
solo_correct = false;
team_correct = false;
solo_wrong = false;
team_wrong = false;
team_turn = 0;
solo_actions = [];
team_actions = [];
solo_current = -1;
team_current = -1;
next_seed_inline();

repeat (100) {
	array_push(solo_actions, press_actions[irandom(array_length(press_actions) - 1)]);
	array_push(team_actions, press_actions[irandom(array_length(press_actions) - 1)]);
}

network_solo_actions = [];
network_team_actions = [];

alarm_override(1, function() {
	alarm_instant(4);
	alarm_instant(5);
});

alarm_create(4, function() {
	with (points_teams[1][0]) {
		sprite_index = skin[$ "Idle"];
		hspeed = 0;
	}

	solo_current++;
	solo_current %= array_length(solo_actions);
	solo_action = solo_actions[solo_current];
	solo_correct = false;
	solo_wrong = false;
});

alarm_create(5, function() {
	for (var i = 0; i < array_length(points_teams[0]); i++) {
		with (points_teams[0][i]) {
			hspeed = 0;
		}
	}

	with (objMinigame1vs3_Race_Gradius) {
		image_index = 0;
		hspeed = 0;
	}

	next_seed_inline();

	if (team_correct) {
		team_turn++;
		team_turn %= 3;
	}

	team_current++;
	team_current %= array_length(team_actions);
	team_action = team_actions[team_current];
	team_correct = false;
	team_wrong = false;
});

alarm_override(11, function() {
	if (global.player_id != 1) {
		return;
	}

	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
	
		with (player) {
			var action = null;
		
			if (irandom(19) != 0) {
				if (image_xscale > 1 && other.solo_action != null) {
					action = actions[$ other.solo_action];
				}
			
				if (image_xscale == 1 && other.team_action != null) {
					action = actions[$ other.team_action];
				}
			} else {
				action = actions[$ other.press_actions[irandom(array_length(other.press_actions) - 1)]];
			}
		
			if (action != null) {
				action.press();
			}
		}
	}

	alarm_call(11, 1.7);
});