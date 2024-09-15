if (other.object_index == objMinigame4vs_Targets_Blocker) {
	exit;
}

if (other.object_index == objMinigame4vs_Treasure_Block) {
	with (other) {
		treasure_block_hit(other.network_id);
	}
}

instance_destroy();