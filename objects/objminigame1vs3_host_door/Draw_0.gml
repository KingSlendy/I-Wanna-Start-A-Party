draw_self();

with (objPlayerBase) {
	if (frozen || !draw || !place_meeting(x, y, other)) {
		continue;
	}
	
	draw_sprite_ext(global.actions.up.bind(), 0, x, y - 30, 0.4, 0.4, 0, c_white, 1);
}