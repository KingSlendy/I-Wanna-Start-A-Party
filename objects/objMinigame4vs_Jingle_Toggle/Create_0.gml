function toggle_block() {
	sprite_index = (sprite_index == sprMinigame4vs_Jingle_ToggleFull) ? sprMinigame4vs_Jingle_ToggleEmpty : sprMinigame4vs_Jingle_ToggleFull;
}

next_seed_inline();

if (0.5 > irandom(1)) {
	toggle_block();
}