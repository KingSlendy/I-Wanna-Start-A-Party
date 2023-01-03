event_inherited();
network_mode = PlayerDataMode.Golf;
aiming = true;
powering = false;
aim_angle = 45;
aim_power = 0;
powering_dir = 1;
max_velocity = 700;
on_block = false;
shot = false;
hole = false;
sound_count = 0;
phy_speed_previous = 0;

function hit_ball() {
	var total_power = aim_power * max_velocity;
	phy_linear_velocity_x = lengthdir_x(total_power, aim_angle);
	phy_linear_velocity_y = lengthdir_y(total_power, aim_angle);
	phy_angular_velocity = -200;
	aiming = false;
	powering = false;
	shot = true;
	audio_play_sound(sndMinigame4vs_Golf_Hit, 0, false, 0.1 + (0.9 * aim_power));
}