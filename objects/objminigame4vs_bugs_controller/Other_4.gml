event_inherited();
next_seed_inline();
count_bug = asset_get_index("sprMinigame4vs_Bugs_Bug" + choose("R", "G", "B", "Y"));

repeat (70) {
	with (instance_create_layer(irandom_range(128 - 16, 672 + 16), irandom_range(192 - 16, 384 + 16), "Actors", objMinigame4vs_Bugs_Bug)) {
		sprite_index = asset_get_index("sprMinigame4vs_Bugs_Bug" + choose("R", "G", "B", "Y"));
		image_index = irandom(image_number - 1);
	}
}