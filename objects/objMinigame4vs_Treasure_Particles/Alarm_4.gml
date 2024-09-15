with (instance_create_layer(irandom(room_width) + irandom(512), room_height + 128, "Actors", objMinigame4vs_Treasure_Iris)) {
	depth = layer_get_depth("Tiles") + 1;
}

alarm[4] = irandom(5) + 5;