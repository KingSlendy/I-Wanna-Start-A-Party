if (other.object_index == objMinigame4vs_Jingle_Goal || !is_player_local(focus_player_by_turn(player_turn).network_id)) {
	exit;
}

if (other.object_index == objMinigame4vs_Jingle_Toggle && other.sprite_index == sprMinigame4vs_Jingle_ToggleEmpty) {
	exit;
}

sledge_hit();