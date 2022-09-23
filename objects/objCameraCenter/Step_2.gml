var min_player_x = infinity;
var min_player_y = infinity;
var max_player_x = -infinity;
var max_player_y = -infinity;

with (objPlayerBase) {
	if (!draw || lost) {
		continue;
	}
	
	min_player_x = min(x, min_player_x);
	min_player_y = min(y, min_player_y);
	max_player_x = max(x, max_player_x);
	max_player_y = max(y, max_player_y);
}

var ratio = 800 / 608;
var edge_size = 100;
min_player_x -= edge_size * ratio;
min_player_y -= edge_size;
max_player_x += edge_size * ratio;
max_player_y += edge_size;

var dist_x = max_player_x - min_player_x;
var dist_y = max_player_y - min_player_y;
target_h = dist_y * max(dist_x / dist_y, 1);
target_w = target_h * ratio;
view_w = lerp(view_w, target_w, view_spd);
view_h = lerp(view_h, target_h, view_spd);
target_x = min_player_x + floor(dist_x / 2) - floor(view_w / 2);
target_y = min_player_y;
view_x = lerp(view_x, target_x, view_spd);
view_y = lerp(view_y, target_y, view_spd);

if (boundaries) {
	view_w = clamp(view_w, 0, room_width);
	view_h = clamp(view_h, 0, room_height);
	view_x = clamp(view_x, 0, room_width - view_w);
	view_y = clamp(view_y, 0, room_height - view_h);
}

camera_set_view_size(view_camera[camera], view_w, view_h);
camera_set_view_pos(view_camera[camera], view_x, view_y);