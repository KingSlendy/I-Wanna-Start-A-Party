surf = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
surface_copy(surf, 0, 0, application_surface);
switch_x = null;
switch_y = null;
final_action = null;

function snap_camera() {
	with (objCamera) {
		target_x = other.switch_x;
		target_y = other.switch_y;
		view_x = target_x;
		view_y = target_y;
	}
}