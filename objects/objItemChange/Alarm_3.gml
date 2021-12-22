///@desc Item Use Animation
var focus = focused_player_turn();
spawned_item = instance_create_layer(focus.x, focus.y - 40, "Actors", objItem);
spawned_item.sprite_index = item.sprite;
alarm[11] = game_get_speed(gamespeed_fps) * 1.5;