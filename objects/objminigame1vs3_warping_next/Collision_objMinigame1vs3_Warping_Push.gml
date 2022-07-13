instance_create_layer(x, 160, "Collisions", objBlock, {
	visible: true,
	sprite_index: sprMinigame1vs3_Warping_Push
});

instance_create_layer(704, -32, "Actors", objMinigame1vs3_Warping_Push);
instance_destroy(other);
instance_destroy();