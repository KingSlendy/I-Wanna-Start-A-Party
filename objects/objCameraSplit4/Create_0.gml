event_inherited();
function init_view() {}

boundaries = false;

for (var i = 0; i < global.player_max; i++) {
	target_follow[i] = null;
	view_x[i] = 0;
	view_y[i] = 0;
	target_x[i] = 0;
	target_y[i] = 0;
	view_visible[i] = true;
}

view_surfs = array_create(global.player_max, noone);
application_surface_draw_enable(false);