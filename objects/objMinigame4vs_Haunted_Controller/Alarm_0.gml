if (state++ == 1) {
	event_inherited();
	next_seed_inline();
	objMinigame4vs_Haunted_Boo.alarm[0] = irandom_range(get_frames(2), get_frames(4));
} else {
	objMinigame4vs_Haunted_Boo.alarm[0] = get_frames(0.5);
}
