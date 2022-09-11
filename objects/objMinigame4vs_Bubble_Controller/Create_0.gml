with (objPlayerBase) {
	change_to_object(objPlayerBubble);
}

objPlayerBase.goal_num = 0;

event_inherited();

points_draw = true;
player_check = objPlayerBubble;