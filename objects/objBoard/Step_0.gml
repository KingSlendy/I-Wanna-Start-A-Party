if (is_player_turn() && global.can_open_map && !instance_exists(objMapLook) && global.actions.shoot.pressed()) {
	instance_create_layer(0, 0, "Managers", objMapLook);
}