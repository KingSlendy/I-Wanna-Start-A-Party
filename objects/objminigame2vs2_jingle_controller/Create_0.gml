with (objPlayerBase) {
	change_to_object(objPlayerStatic);
}

objPlayerBase.sledge = null;

event_inherited();

minigame_start = minigame2vs2_start;
action_end = function() {
	alarm_stop(4);
	alarm_stop(5);
	set_spd(0, false);
	set_spd(0, true);
}

player_check = objPlayerStatic;

space_count = [0, 0];
space_objs = [[], []];
next_seed_inline();

repeat (100) {
	array_push(space_objs[0], irandom(3));
	array_push(space_objs[1], irandom(3));
}

sledge_start = false;

function set_spd(scene_spd, down) {
	var bg_layers = ["Background", "Trees"];
	
	for (var i = 0; i < array_length(bg_layers); i++) {
		var bg_layer = bg_layers[i] + "_" + ((down) ? "Down" : "Up");
		var spd = scene_spd * (0.3 * (i + 1));
		layer_hspeed(bg_layer, spd);
	}
	
	with (objMinigame2vs2_Jingle_Block) {
		if ((down && y < 304) || (!down && y > 304)) {
			continue;
		}
		
		hspeed = scene_spd;
	}
	
	with (objMinigame2vs2_Jingle_Spike) {
		if ((down && y < 304) || (!down && y > 304)) {
			continue;
		}
		
		hspeed = scene_spd;
	}
}

alarm_override(1, function() {
	alarm_instant(4);
	alarm_instant(5);
	sledge_start = true;
});

alarm_create(4, function() {
	var start_x = -infinity;

	with (objMinigame2vs2_Jingle_Block) {
		if (y > 304) {
			continue;
		}
		
		start_x = max(start_x, x);
	}

	start_x += 32;
	var start_y = 208;
		
	for (var j = 0; j < 3; j++) {
		instance_create_layer(start_x, start_y + 32 * j, "Collisions", (j == 0) ? objMinigame2vs2_Jingle_Block : objMinigame2vs2_Jingle_Block2);
	}
		
	if (space_count[0] % 10 == 0) {
		var objs = [objMinigame2vs2_Jingle_Spike, objMinigame2vs2_Jingle_Tree, objMinigame2vs2_Jingle_Candy, null];
		var count = floor(space_count[0] / 10);
		var obj = null;
		
		if (count < 40) {
			obj = objs[space_objs[0][count]];
		} else if (count == 30) {
			obj = objMinigame2vs2_Jingle_Goal;
		}
			
		if (obj != null) {
			instance_create_layer(start_x, start_y - sprite_get_height(object_get_sprite(obj)), "Actors", obj);
		}
	}
	
	space_count[0]++;
	set_spd(-7, false);
	alarm_call(4, 0.08);
});

alarm_create(5, function() {
	var start_x = -infinity;

	with (objMinigame2vs2_Jingle_Block) {
		if (y < 304) {
			continue;
		}
		
		start_x = max(start_x, x);
	}

	start_x += 32;
	var start_y = 208 + 304;
		
	for (var j = 0; j < 3; j++) {
		instance_create_layer(start_x, start_y + 32 * j, "Collisions", (j == 0) ? objMinigame2vs2_Jingle_Block : objMinigame2vs2_Jingle_Block2);
	}
		
	if (space_count[1] % 10 == 0) {
		var objs = [objMinigame2vs2_Jingle_Spike, objMinigame2vs2_Jingle_Tree, objMinigame2vs2_Jingle_Candy, null];
		var count = floor(space_count[1] / 10);
		var obj = null;
		
		if (count < 40) {
			obj = objs[space_objs[1][count]];
		} else if (count == 30) {
			obj = objMinigame2vs2_Jingle_Goal;
		}
			
		if (obj != null) {
			instance_create_layer(start_x, start_y - sprite_get_height(object_get_sprite(obj)), "Actors", obj);
		}
	}
	
	space_count[1]++;
	set_spd(-7, true);
	alarm_call(5, 0.08);
});