draw_self();

with (instance_place(x, y, objPlayerBase)) {
	if (frozen || !draw) {
		break;
	}
	
	draw_sprite_ext(global.actions.up.bind(), 0, x, y - 30, 0.4, 0.4, 0, c_white, 1);
}