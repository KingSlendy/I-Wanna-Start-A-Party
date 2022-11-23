var player = instance_place(x, y - 1, objPlayerBase);

if (enabled && !active && !place_meeting(x, y, objBlock) && player != noone && is_player_local(player.network_id)) {
	block_destabilize();
}