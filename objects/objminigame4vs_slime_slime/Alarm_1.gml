sprite_index = sprMinigame4vs_Slime_Slime;

if (instance_exists(objMinigame4vs_Slime_Block)) {
	objMinigame4vs_Slime_Block.scale_target = 0;
}

music_resume();

if (player.lost) {
	with (objMinigameController) {
		unfreeze_player();
	}
	
	exit;
}

if (!is_player_local(player.network_id)) {
	exit;
}

player.enable_shoot = false;
player.frozen = false;
instance_create_layer(384, 480, "Collisions", objMinigame4vs_Slime_Next, {
	image_xscale: 5
});