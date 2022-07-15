var warps = ds_list_create();
instance_place_list(x, y, objMinigame2vs2_Duos_Warp, warps, false);
ds_list_shuffle(warps);

while (ds_list_size(warps) > 1) {
	warps[| 0].target = warps[| 1];
	warps[| 1].target = warps[| 0];
	var new_warps = [];
	
	with (instance_create_layer(warps[| 0].x, warps[| 0].y + 32 * 5, "Actors", objMinigame2vs2_Duos_Warp)) {
		image_blend = warps[| 0].image_blend;
		new_warps[0] = id;
	}
	
	with (instance_create_layer(warps[| 1].x, warps[| 1].y + 32 * 5, "Actors", objMinigame2vs2_Duos_Warp)) {
		image_blend = warps[| 1].image_blend;
		new_warps[1] = id;
	}
	
	new_warps[0].target = new_warps[1];
	new_warps[1].target = new_warps[0];
	
	ds_list_delete(warps, 0);
	ds_list_delete(warps, 0);
}

warps[| 0].reference = reference;

with (instance_create_layer(warps[| 0].x, warps[| 0].y + 32 * 5, "Actors", objMinigame2vs2_Duos_Warp)) {
	image_blend = warps[| 0].image_blend;
	reference = other.reference + 1;
}

ds_list_destroy(warps);
instance_destroy();