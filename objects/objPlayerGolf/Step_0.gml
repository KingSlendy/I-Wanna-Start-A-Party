phy_active = (!lost);

if (frozen) {
	exit;
}

if (shot && !hole) {
	if (phy_speed < 0.005) {
		with (objMinigameController) {
			if (other.x < objMinigame4vs_Golf_Flag.x + 28) {
				var dist = point_distance(other.phy_position_x + 10, other.phy_position_y, objMinigame4vs_Golf_Flag.x + 26, other.phy_position_y);
			} else {
				var dist = point_distance(other.phy_position_x - 10, other.phy_position_y, objMinigame4vs_Golf_Flag.x + 30, other.phy_position_y);
			}
			
			give_points(other.network_id, clamp(100 - ceil(dist * 0.2), 0, 100));
		}
		
		hole = true;
	}
	
	if (place_meeting(x, y, objMinigame4vs_Golf_Hole)) {
		with (objMinigameController) {
			give_points(other.network_id, 100);
		}
		
		hole = true;
		audio_play_sound(sndMinigame4vs_Golf_Sink, 0, false);
	}
}

on_block = (place_meeting(x, y + 2, objMinigame4vs_Golf_Block));
phy_angular_damping = (on_block) ? 4 : 0;

if (aiming && !powering) {
	aim_angle += (global.actions.left.held(network_id) - global.actions.right.held(network_id)) * 2;
	aim_angle = clamp(aim_angle, 0, 90);
	
	if (global.actions.jump.pressed(network_id)) {
	    powering = true;
	    aim_power = 0.5;
		global.actions.jump.consume();
	}
}

if (powering) {
	aim_power += 0.02 * powering_dir;
		
	if (aim_power < 0 || aim_power > 1) {
	    powering_dir *= -1;
	}
		
	aim_power = clamp(aim_power, 0, 1);
		
	if (global.actions.jump.pressed(network_id)) {
	    var total_power = aim_power * max_velocity;
	    phy_linear_velocity_x = lengthdir_x(total_power, aim_angle);
	    phy_linear_velocity_y = lengthdir_y(total_power, aim_angle);
	    phy_angular_velocity = -200;
		aiming = false;
		powering = false;
		shot = true;
	    audio_play_sound(sndMinigame4vs_Golf_Hit, 0, false, 0.1 + (0.9 * aim_power));
	}
	
	if (global.actions.shoot.pressed(network_id)) {
		powering = false;
	}
}

sound_count++;
phy_speed_previous = phy_speed;