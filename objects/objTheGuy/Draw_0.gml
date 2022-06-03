var view_x = camera_get_view_x(view_camera[0]);
var view_y = camera_get_view_y(view_camera[0]);

if (draw_surf) {
	if (!surface_exists(surf)) {
		surf = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
		surface_copy(surf, 0, 0, application_surface);
	}
	
	draw_surface(surf, view_x, view_y);
}

draw_set_alpha(fade_alpha);
draw_set_color(c_black);
draw_rectangle(view_x, view_y, view_x + 800, view_y + 608, false);
draw_set_alpha(1);

with (objTheGuyHead) {
	event_perform(ev_draw, ev_gui_begin);
}

if (broken_sprite != noone) {
	draw_sprite(broken_sprite, 0, view_x + broken_x, view_y + broken_y);
}

with (objPlayerBase) {
	if (object_index == objPlayerTheGuy || (object_index == objNetworkPlayer && network_index == objPlayerTheGuy)) {
		draw_self();
	}
}
