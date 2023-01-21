var view_x = camera_get_view_x(view_camera[0]);
var view_y = camera_get_view_y(view_camera[0]);

if (draw_surf) {
	if (!surface_exists(surf)) {
		surf = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
		surface_copy(surf, 0, 0, application_surface);
	}
	
	draw_surface(surf, view_x, view_y);
}

with (objTheGuyHead) {
	event_perform(ev_draw, ev_gui_begin);
}

if (broken_sprite != noone) {
	draw_sprite(broken_sprite, 0, view_x + broken_x, view_y + broken_y);
}