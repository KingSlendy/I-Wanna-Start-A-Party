for (var i = 0; i < 360; i += 360 / cherry_amount) {
	with (instance_create_layer(cherry_x, cherry_y, "Actors", objMinigame1vs3_Kardia_Cherry)) {
		circle = true;
		circle_x = other.cherry_x;
		circle_y = other.cherry_y;
		circle_distance = other.cherry_distance;
		circle_angle = (i + 90 + 360) % 360;
		circle_target_angle = circle_angle;
		circle_reference = other.reference;
			
		if (i == 0) {
			var color = player_color_by_turn(player_info_by_id(minigame1vs3_team(circle_reference).network_id).turn);
				
			switch (color) {
				case c_blue: image_index = 1; break;
				case c_red: image_index = 2; break;
				case c_lime: image_index = 3; break;
				case c_yellow: image_index = 4; break;
			}
			
			image_xscale = 2;
			image_yscale = 2;
			image_blend = c_gray;
		}
	}
}