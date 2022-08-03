image_index = irandom(image_number - 1);
var name = sprite_get_name(sprite_index);
var split = string_split(name, "_");
power_type = split[1];
sound = asset_get_index("snd" + string_copy(name, 4, string_length(name) - 3));