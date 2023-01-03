if (!surface_exists(surf)) {
	surf = surface_create(800, 608);
}

surface_set_target(surf);
draw_clear_alpha(c_black, 0);
gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_one);
shader_set(shdDropShadow);

with (all) {
	if (id == other.id || array_any([objPlayerReference, objBloodEmitter, objBlood, objMinigame1vs3_Warping_Stop, objMinigame1vs3_Warping_Next], function(x) { return (object_index == x); }) || sprite_index == -1) {
		continue;
	}
	
	if (object_is_ancestor(object_index, objPlayerBase)) {
		if (!draw || lost) {
			continue;
		}
		
		event_perform(ev_draw, 0);
	} else {
		draw_self();
	}
}

shader_reset();
surface_reset_target();

draw_surface(surf, 3, 3);

event_inherited();

for (var i = 0; i < minigame1vs3_team_length(); i++) {
	var player = minigame1vs3_team(i);
	
	if (warp_delay[i] == 0) {
		draw_sprite(sprMinigame1vs3_Warping_Warp, 0, player.x - 17, player.y - 42);
	}
}