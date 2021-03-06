with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

event_inherited();

player_check = objPlayerPlatformer;
player_turn = 0;

function unfreeze_player(network = true) {
	instance_destroy(objMinigame4vs_Slime_Blocking);
	instance_destroy(objMinigame4vs_Slime_Next);
	
	if (instance_exists(objMinigame4vs_Slime_Block)) {
		objMinigame4vs_Slime_Block.scale_target = 0;
	}
	
	if (info.is_finished || (player_turn != 0 && !is_player_local(focus_player_by_turn(player_turn).network_id))) {
		return;
	}
	
	do {
		player_turn++;
	
		if (player_turn > global.player_max) {
			player_turn = 1;
		}
	} until (!focus_player_by_turn(player_turn).lost);
	
	with (objPlayerBase) {
		enable_shoot = true;
		frozen = true;
	}
	
	if (player_turn > 0 && network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Slime_UnfreezePlayer);
		network_send_tcp_packet();
	}
	
	var player = focus_player_by_turn(player_turn);
	
	if (!is_player_local(player.network_id)) {
		return;
	}
	
	player.frozen = false;
	instance_create_layer(384, 384, "Collisions", objMinigame4vs_Slime_Blocking, {
		image_xscale: 5
	});
}

function block_entrance(network = true) {
	for (var i = 0; i < 5; i++) {
		instance_create_layer(400 + 32 * i, 464, "Collisions", objMinigame4vs_Slime_Block);
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Slime_BlockEntrance);
		network_send_tcp_packet();
	}
}