max_speed = 5;
follow_path = null;
space_stack = [];
dice_hitting = false;
dice_hit_y = y;

function can_jump() {
	return (!dice_hitting && instance_exists(objDice));
}