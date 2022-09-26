info = global.minigame_info;
layer_background_index(layer_background_get_id("Background"), array_index(minigame_types(), info.type));

with (objPlayerBase) {
	change_to_object(objPlayerBase);
}

with (objPlayerBase) {
	draw = false;
	lost = false;
}

instructions = [];

for (var i = 0; i < array_length(info.reference.instructions); i++) {
	array_push(instructions, new Text(fntDialogue));
}

instructions_page = 0;
option_selected = -1;
choice_texts = [
	"Normal",
	"Practice"
];

state = 0;
fade_alpha = 1;
minigame_info_score_reset();

pages_text = new Text(fntControls);
controls_text = new Text(fntControls);

function start_minigame(set) {
	state = set;
	music_fade();
	audio_play_sound(sndMinigameOverviewPick, 0, false);
}