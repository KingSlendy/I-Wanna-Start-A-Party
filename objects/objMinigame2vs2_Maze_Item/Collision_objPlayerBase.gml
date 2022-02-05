if (!other.has_item && player_info_by_id(other.network_id).space == image_blend) {
	other.has_item = true;
	var h = instance_create_layer(0, 0, "Actors", objMinigame2vs2_Maze_HasItem);
	h.focus_player = other;
	h.image_index = image_index;
	h.image_blend = image_blend;
	instance_destroy();
}