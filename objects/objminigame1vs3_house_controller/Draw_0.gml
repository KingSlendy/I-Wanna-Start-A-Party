event_inherited();

if (!house_start) {
	exit;
}

for (var i = 0; i < array_length(points_teams[0]); i++) {
	var actions = [global.actions.left, global.actions.right, global.actions.jump];
	
	with (points_teams[0][i]) {
		draw_sprite_ext(bind_to_key(actions[i].button), 0, x, y - 50, 0.5, 0.5, 0, c_white, 1);
	}
}