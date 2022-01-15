focus_player = focused_player();
network_id = focus_player.network_id;
space = null;
arrows = array_create(4, null);
actions = [global.actions.up, global.actions.right, global.actions.left, global.actions.down];
arrow_selected = -1;
alarm[0] = 1;