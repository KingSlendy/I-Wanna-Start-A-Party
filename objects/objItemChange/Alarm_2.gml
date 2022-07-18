///@desc Item Lose Animation
focus_player = focus_player_by_id(network_id);
var i = instance_create_layer(focus_player.x, focus_player.y - 40, "Actors", objItem);
i.focus_player = focus_player;
i.sprite_index = item.sprite;
i.alarm[0] = get_frames(1);

alarm[11] = get_frames(1.5);