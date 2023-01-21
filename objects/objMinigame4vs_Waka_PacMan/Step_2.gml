if (intersect == noone) {
	var intersect_left = instance_place(x - 16, y, objMinigame4vs_Waka_Intersect);
	var intersect_right = instance_place(x + 16, y, objMinigame4vs_Waka_Intersect);

	if (intersect_left != noone || intersect_right != noone) {
		if (intersect_left != noone ^^ intersect_right != noone) {
			intersect = (intersect_left != noone) ? intersect_left : intersect_right;
		} else {
			intersect = choose(intersect_left, intersect_right, null);
		}
	
		if (intersect != null && intersect != prev_intersect && (prev_intersect == null || intersect.y != prev_intersect.y) && y >= intersect.y + 16) {
			y = intersect.y + 16;
			image_angle = (intersect_left != noone) ? 180 : 0;
			hspeed = (intersect_left != noone) ? -max_spd : max_spd;
			vspeed = 0;
		} else {
			intersect = noone;
		}
	}
} else if (!place_meeting(x, y, intersect)) {
	if (x < intersect.bbox_left) {
		x = intersect.bbox_left - 16;
	} else if (x > intersect.bbox_right) {
		x = intersect.bbox_right + 16;
	}
	
	start_path();
	prev_intersect = intersect;
	intersect = noone;
}