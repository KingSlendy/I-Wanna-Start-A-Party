info = global.minigame_info;
instructions = [];

for (var i = 0; i < array_length(info.reference.instructions); i++) {
	array_push(instructions, new Text(fntDialogue, info.reference.instructions[i]));
}

instructions_page = 0;
option_selected = -1;
choice_texts = [
	"Normal",
	"Practice"
];

state = 0;
alpha = 1;
minigame_info_score_reset();

function start_minigame(set) {
	state = set;
	audio_play_sound(global.sound_cursor_select, 0, false);
}
