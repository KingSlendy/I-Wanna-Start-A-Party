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

network_solo_actions = [];
network_team_actions = [];
