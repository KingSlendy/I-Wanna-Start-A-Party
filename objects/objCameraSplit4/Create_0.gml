event_inherited();
function init_view() {}

boundaries = false;
draw_names = true;

switch (room) {
	case rMinigame4vs_Tower:
		var w = 200;
		var h = 608;
		mode = 1;
		break;
		
	case rMinigame1vs3_Race:
		var w = 800;
		var h = 304;
		mode = 2;
		draw_names = false;
		break;
		
	case rMinigame2vs2_Duos:
		var w = 800;
		var h = 152;
		mode = 2;
		break;
	
	default:
		var w = 400;
		var h = 304;
		mode = 0;
		break;
}

for (var i = 0; i < global.player_max; i++) {
	target_follow[i] = null;
	view_x[i] = 0;
	view_y[i] = 0;
	target_x[i] = 0;
	target_y[i] = 0;
	view_visible[i] = true;
	view_wport[i] = w;
	view_hport[i] = h;
	var camera = view_camera[i];
	camera_set_view_size(camera, w, h);
}

view_surfs = array_create(global.player_max, noone);
application_surface_draw_enable(false);
dead = array_create(global.player_max, false);
lock_x = false;
lock_y = false;