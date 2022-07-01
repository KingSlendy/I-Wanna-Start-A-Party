event_inherited();

repeat (70) {
	with (instance_create_layer(irandom_range(128 - 16, 672 + 16), irandom_range(192 - 16, 384 + 16), "Actors", objMinigame4vs_Bugs_Bug)) {
		event_perform(ev_other, ev_room_start);
	}
}