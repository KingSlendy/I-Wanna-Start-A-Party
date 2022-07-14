instance_create_layer(x, 160, "Collisions", objBlock, {
	visible: true,
	sprite_index: sprMinigame1vs3_Warping_Push
});

if (x != 32) {
	instance_create_layer(608, -32, "Actors", objMinigame1vs3_Warping_Push);
}

instance_destroy(other);
instance_destroy();