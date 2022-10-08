if (player != null && is_player_local(player.network_id) && held && !player.frozen && global.actions.jump.released(player.network_id)) {
	release_item();
}

if (state == 0) {
	image_xscale += 0.03;
	image_yscale += 0.03;
	
	if (image_xscale >= 1.5) {
		image_xscale = 1.5;
		image_yscale = 1.5;
		state = 1;
	}
} else if (state == 1) {
	image_xscale -= 0.03;
	image_yscale -= 0.03;
	
	if (image_xscale <= 1) {
		image_xscale = 1;
		image_yscale = 1;
		state = -1;
	}
}

vspd += grav;
x += hspd;
y += vspd;

if (bbox_bottom >= giver.bbox_bottom) {
	hspd = 0;
	vspd = 0;
	grav = 0;
}

x = clamp(x, giver.bbox_left + 15, giver.bbox_right - 15);
y = clamp(y, giver.bbox_top + 15, giver.bbox_bottom - 15);