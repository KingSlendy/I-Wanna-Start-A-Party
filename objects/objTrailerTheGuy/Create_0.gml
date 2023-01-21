depth = -9003;
surf = noone;
draw_surf = false;
broken_sprite = noone;
broken_x = 400;
broken_y = 304;
broken_hspd = 0;
broken_vspd = 0;
broken_grav = 0;

alarms_init(10);

alarm_create(function() {
	var view_x = camera_get_view_x(view_camera[0]);
	var view_y = camera_get_view_y(view_camera[0]);
	instance_create_layer(view_x + 380, view_y + 284, "Actors", objTheGuyHead);
	draw_surf = true;

	var broken_surf = surface_create(800, 608);
	surface_set_target(broken_surf);
	draw_sprite(sprTheGuyBroken, 0, 400, 304);
	gpu_set_colorwriteenable(true, true, true, false);
	draw_surface(application_surface, 0, 0);
	gpu_set_colorwriteenable(true, true, true, true);
	surface_reset_target();
	broken_sprite = sprite_create_from_surface(broken_surf, 0, 0, 800, 608, false, false, 400, 304);
	surface_free(broken_surf);

	broken_hspd = irandom_range(-4, 4);
	broken_vspd = irandom_range(-6, -4);
	broken_grav = 0.5;
});

alarm_call(0, 1);