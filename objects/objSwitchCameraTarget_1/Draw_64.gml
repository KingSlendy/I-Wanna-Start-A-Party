if (!surface_exists(surf)) {
	surf = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
	surface_copy(surf, 0, 0, application_surface);
}

draw_set_alpha(image_alpha);
draw_surface(surf, 0, 0);
draw_set_alpha(1);