event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	with (objPlayerBase) {
		press_delay = get_frames(random_range(0.75, 1.25));
	}
}

minigame_camera = CameraMode.Split4;
action_end = function() {
	solo_action = null;
	team_action = null;
	alarm_stop(4);
	alarm_stop(5);
}

player_type = objPlayerStatic;

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
solo_action_total = 5;
team_action_total = 3;
solo_current = -1;
team_current = -1;
solo_advance = 0;
team_advance = 0;
next_seed_inline();
var current_solo_action = null;
var prev_solo_action = null;
var current_team_action = null;
var prev_team_action = null;

repeat (100) {
	do {
		current_solo_action = press_actions[irandom(array_length(press_actions) - 1)];
	} until (current_solo_action != prev_solo_action);
	
	array_push(solo_actions, current_solo_action);
	prev_solo_action = current_solo_action;
	
	do {
		current_team_action = press_actions[irandom(array_length(press_actions) - 1)];
	} until (current_team_action != prev_team_action);
	
	array_push(team_actions, current_team_action);
	prev_team_action = current_team_action;
}

network_solo_actions = [];
network_team_actions = [];

alarm_override(1, function() {
	alarm_instant(4);
	alarm_instant(5);
});

alarm_create(4, function() {
	with (minigame1vs3_solo()) {
		if (!is_player_local(network_id)) {
			break;
		}
		
		sprite_index = skin[$ "Idle"];
		hspeed = 0;
	}
	
	if (solo_correct) {
		solo_advance++;
	}

	if (!solo_wrong) {
		solo_current++;
		solo_current %= array_length(solo_actions);
		solo_action = solo_actions[solo_current];
	}
	
	solo_advance %= solo_action_total;
	solo_correct = false;
	solo_wrong = false;
});

alarm_create(5, function() {
	for (var i = 0; i < minigame1vs3_team_length(); i++) {
		with (minigame1vs3_team(i)) {
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
		team_turn %= team_action_total;
	}

	if (!team_wrong) {
		team_current++;
		team_current %= array_length(team_actions);
		team_action = team_actions[team_current];
	}
	
	team_advance %= team_action_total;
	team_correct = false;
	team_wrong = false;
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
	
		with (player) {
			if (minigame1vs3_team(other.team_turn).network_id != i && minigame1vs3_solo().network_id != i) {
				break;
			}
			
			if (press_delay > 0) {
				press_delay--;
				break;
			}
			
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
				press_delay = get_frames(random_range(0.55, 1));
			}
		}
	}

	alarm_frames(11, 1);
});