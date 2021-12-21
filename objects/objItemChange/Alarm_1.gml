///@desc Item Gain Animation
var focus = focused_player_turn();
var i = instance_create_layer(focus.x, focus.y - 40, "Actors", objItem);
i.sprite_index = item.sprite;
i.vspeed = -6;
i.gravity = 0.3;
alarm[11] = game_get_speed(gamespeed_fps) * 1;