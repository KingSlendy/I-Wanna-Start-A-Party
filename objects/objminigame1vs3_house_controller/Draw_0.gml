event_inherited();

if (!house_start) {
	exit;
}

for (var i = 0; i < array_length(points_teams[0]); i++) {
	var actions = [global.actions.left, global.actions.right, global.actions.jump];
	
	with (minigame1vs3_team(i)) {
		draw_sprite_ext(actions[i].bind(), 0, x, y - 50, 0.5, 0.5, 0, c_white, 1);
	}
}