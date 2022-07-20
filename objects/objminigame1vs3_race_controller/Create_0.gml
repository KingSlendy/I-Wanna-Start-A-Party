with (objPlayerBase) {
	change_to_object(objPlayerStatic);
}

event_inherited();

minigame_start = minigame1vs3_start;
minigame_camera = CameraMode.Split4;
action_end = function() {
	solo_action = null;
	team_action = null;
	alarm[4] = 0;
	alarm[5] = 0;
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