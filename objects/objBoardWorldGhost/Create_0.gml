event_inherited();
network_mode = null;
skin = null;
network_id = global.player_max + 1;
normal_sprite = sprite_index;
event_sprite = sprBoardWorldGhostTake;
encountered = false;

function change_to_object(obj) {}

alarm_create(0, function() {
	array_delete(global.player_ghost_shines, 0, 1);
	board_world_ghost_switch(false);
});