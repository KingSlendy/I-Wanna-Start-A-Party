image_alpha = lerp(image_alpha, alpha_target, 0.3);

if (player == null || player.frozen) {
	exit;
}

if (global.actions.shoot.pressed(player.network_id)) {
	curtain_switch();
}