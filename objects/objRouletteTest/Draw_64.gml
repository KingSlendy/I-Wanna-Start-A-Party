var priority = ds_priority_create();

for (var i = 0; i < array_length(minigames); i++) {
	var minigame = minigames[i];
	var angle = roulette_angle + roulette_separation * i;
	ds_priority_add(priority, { minigame, angle }, lengthdir_y(1, angle));
}

var size = ds_priority_size(priority);

for (var i = 0; i < size; i++) {
	var current = ds_priority_delete_min(priority);
	var minigame = current.minigame;
	var angle = current.angle;
	
	if (i == size - 1 && minigame.title != minigame_previous) {
		if (roulette_spd == 1 && minigame.title == minigame_chosen.title) {
			roulette_chosen = true;
			audio_play_sound(sndRoulettePick, 0, false);
			print(roulette_angle);
		}
		
		audio_play_sound(sndRouletteRoll, 0, false);
		minigame_previous = minigame.title;
	}
	
	var portrait = (minigame_seen(minigame.title)) ? minigame.portrait : minigame.hidden;
	var scale = remap(lengthdir_y(1, angle), -1, 1, 0.5, 1);
	var blend = (i != size - 1) ? c_gray : c_white;
	draw_sprite_ext(portrait, 0, 400 + lengthdir_x(300, angle) * roulette_spread, 304 + lengthdir_y(50, angle) * roulette_spread, scale, scale, 0, blend, 1);
}

ds_priority_destroy(priority);