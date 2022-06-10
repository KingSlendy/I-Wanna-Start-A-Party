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
	audio_play_sound(sndMinigameOverviewPick, 0, false);
}

var w = sprite_get_width(sprMinigameOverview_Preview);
var h = sprite_get_height(sprMinigameOverview_Preview);
var surf = surface_create(w, h);
surface_set_target(surf);
draw_sprite(sprMinigameOverview_Preview, 1, w / 2, h / 2);
gpu_set_colorwriteenable(true, true, true, false);

if (info.reference.preview != -1) {
	draw_sprite_stretched(sprMinigameOverview_Pictures, info.reference.preview, 44, 15,  w - 88, h - 31);
}

gpu_set_colorwriteenable(true, true, true, true);
draw_sprite(sprMinigameOverview_Preview, 0, w / 2, h / 2);
surface_reset_target();
sprite_preview = sprite_create_from_surface(surf, 0, 0, w, h, false, false, w / 2, h / 2);
surface_free(surf);
