next_seed_inline();
count_bug = asset_get_index("sprMinigame4vs_Bugs_Bug" + choose("R", "G", "B", "Y"));
var min_count = irandom_range(15, 30);
var min_count_current = 0;

repeat (80) {
	with (instance_create_layer(irandom_range(128 - 16, 672 + 16), irandom_range(192 - 16, 384 + 16), "Actors", objMinigame4vs_Bugs_Bug)) {
		if (min_count_current++ < min_count) {
			sprite_index = other.count_bug;
		} else {
			sprite_index = asset_get_index("sprMinigame4vs_Bugs_Bug" + choose("R", "G", "B", "Y"));
		}
		
		image_index = irandom(image_number - 1);
	}
}

with (objMinigame4vs_Bugs_Bug) {
	if (sprite_index == other.count_bug) {
		array_push(other.bugs, id);
	}
}
	
total_bugs = array_length(bugs);
event_inherited();