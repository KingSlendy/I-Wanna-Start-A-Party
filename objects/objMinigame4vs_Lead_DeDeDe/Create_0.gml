action_sprites = [
	"Right",
	"Right",
	"Down",
	"Jump",
	"Attack"
];

action_shown = 0;
action = -1;

alarms_init(1);

alarm_create(function() {
	objMinigame4vs_Lead_Bubble.visible = true;

	try {
		action = objMinigameController.sequence[action_shown++];
		var dir = action_sprites[action];
		image_speed = 1;
		sprite_index = asset_get_index("sprMinigame4vs_Lead_DeDeDe_" + dir);
		image_index = 0;
	
		if (action == 1) {
			image_xscale = -2;
		} else {
			image_xscale = 2;
		}
	
		objMinigame4vs_Lead_Bubble.action_shown = action;
		alarm_call(0, 1.5);
		audio_play_sound(asset_get_index("sndMinigame4vs_Lead_DeDeDe_" + dir), 0, false);
	} catch (_) {
		sprite_index = sprMinigame4vs_Lead_DeDeDe_End;
		image_xscale = 2;
		action_shown = 0;
	
		with (objMinigame4vs_Lead_Bubble) {
			visible = false;
			action_shown = -1;
		}
			
		with (objMinigameController) {
			alarm_call(0, 1);
		}
	}
});