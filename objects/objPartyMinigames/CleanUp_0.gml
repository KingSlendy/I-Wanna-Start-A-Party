surface_free(surf);
sprite_delete(save_sprite);
var names = variable_struct_get_names(minigames_portraits);

for (var i = 0; i < array_length(names); i++) {
	for (var j = 0; j < array_length(minigames_portraits[$ names[i]]); j++) {
		sprite_delete(minigames_portraits[$ names[i]][j]);
	}
}
