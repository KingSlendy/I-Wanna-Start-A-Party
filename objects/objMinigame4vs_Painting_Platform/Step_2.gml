with (objPlayerBase) {
	if (is_player_local(network_id) && place_meeting(xprevious, yprevious, other) && global.actions.jump.pressed(network_id)) {
		other.platform_paint(network_id);
		break;
	}
}