///@desc Item Gain Animation
var focus = focused_player();
var i = instance_create_layer(focus.x, focus.y - 40, "Actors", objItem);
i.sprite_index = item.sprite;
i.vspeed = -6;
i.gravity = 0.3;
alarm[11] = get_frames(1);