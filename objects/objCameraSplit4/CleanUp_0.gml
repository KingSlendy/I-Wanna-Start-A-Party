for (var i = 0; i < global.player_max; i++) {
	surface_free(view_surfs[i]);
}

view_wport[0] = 800;
view_hport[0] = 608;
camera_set_view_size(view_camera[0], 800, 608);
application_surface_draw_enable(true);