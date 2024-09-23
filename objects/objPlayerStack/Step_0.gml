var dir_left = global.actions[$ left_action].held(network_id);
var dir_right = global.actions[$ right_action].held(network_id);
var dir = 0;

//If the player is frozen no movement is applied
if (!frozen && enable_move) {
    if (dir_right) {
        dir = 1;
	} else if (dir_left) {
        dir = -1;
	}
}

on_block = place_meeting(x, y + orientation, objMinigame2vs2_Stacking_Block);

if (dir != 0) {
	xscale = dir;
	phy_linear_velocity_x = max_hspd * dir;
	sprite_index = skin[$ "Run"];
} else {
	phy_linear_velocity_x = 0;
	sprite_index = skin[$ "Idle"];
}