if (surface_exists(surf)) {
	surface_free(surf);
}

if (ds_exists(skins, ds_type_list)) { 
	ds_list_destroy(skins);
}

if (sprite_exists(save_sprite)) {
	sprite_delete(save_sprite);
}