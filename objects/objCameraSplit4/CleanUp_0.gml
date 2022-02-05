for (var i = 0; i < global.player_max; i++) {
	surface_free(view_surfs[i]);
}

application_surface_draw_enable(true);