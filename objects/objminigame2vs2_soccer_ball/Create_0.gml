depth = layer_get_depth("Tiles") + 1;
image_speed = 0;
movable = true;
hittable = true;

function soccer_goal(network = true) {
	objPlayerBase.frozen = true;

	with (objMinigameController) {
		minigame4vs_points(points_teams[(other.x < 400)][0].network_id, 1);
	}

	hspeed = 0;
	vspeed = 0;
	gravity = 0;
	movable = false;

	show_popup("GOAL!");
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