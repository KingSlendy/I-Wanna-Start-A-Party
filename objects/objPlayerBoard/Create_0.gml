event_inherited();
network_mode = PlayerDataMode.Basic;
skin = get_skin();
max_speed = 6;
follow_path = null;
can_jump = false;
has_hit = false;
jump_y = y;
alpha_target = 1;

function snap_to_object(obj) {
	y = yprevious;

	while (!place_meeting(x, y - 1, obj)) {
		y--;
	}

	vspeed = 0;
}

function board_jump() {
	vspeed = -6;
	gravity = 0.4;
	jump_y = y;
	can_jump = false;
	audio_play_sound(sndJump, 0, false);
}