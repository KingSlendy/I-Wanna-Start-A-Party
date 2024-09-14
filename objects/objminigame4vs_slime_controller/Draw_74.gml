event_inherited();
draw_sprite(sprMinigame4vs_Slime_Portrait, 0, 592, 432);

if (player_turn != 0 && !info.is_finished) {
	draw_sprite_ext(get_skin_pose_object(focus_player_by_turn(player_turn), "Idle"), 0, 642, 482, 2, 2, 0, c_white, 1);
}