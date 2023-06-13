depth = layer_get_depth("Tiles") + 1;
image_speed = 0;
movable = true;
hittable = false;

function soccer_goal(network = true) {
	objPlayerBase.frozen = true;

	with (objMinigameController) {
		team_just_score = (other.x < 400); 
		minigame4vs_points(minigame2vs2_team(team_just_score, 0).network_id, 1);
		alarm_call(4, 0.25);
	}

	hspeed = 0;
	vspeed = 0;
	gravity = 0;
	movable = false;
	hittable = false;

	show_popup(language_get_text("MINIGAMES_SOCCER_GOAL"));
	audio_play_sound(sndMinigameGoal, 0, false);
	alarm_call(0, 2);
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Soccer_Goal);
		buffer_write_data(buffer_s32, x);
		buffer_write_data(buffer_s32, y);
		network_send_tcp_packet();
	}
}

alarms_init(2);

alarm_create(function() {
	with (objMinigameController) {
		if (trial_is_title(TINY_TEAMING) && minigame2vs2_get_points_team(0) == 1) {
			minigame4vs_set_points(minigame2vs2_team(0, 0).network_id, 5);
			minigame4vs_set_points(minigame2vs2_team(1, 0).network_id, 0);
			minigame_finish();
			return;
		}
		
		if (minigame2vs2_get_points_team(0) == 5 || minigame2vs2_get_points_team(1) == 5) {
			minigame_finish();
			return;
		}
	
		reset = 0;
	}
});

alarm_create(function() {
	hittable = true;
})