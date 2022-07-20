if (!frozen) {
    var left = global.actions.left.held(network_id);
    var right = global.actions.right.held(network_id);
    var up = global.actions.up.held(network_id);
    var down = global.actions.down.held(network_id);
        
    if (gravity == 0 && (left || right || up || down)) {
        gravity = 0.008;
		friction = 0.0005;
    }
        
    if (up) {
		motion_add(image_angle + 90, 0.013);
    }

	image_angle = (image_angle + 360 + (left - right)) % 360;
} else {
    hspeed = 0;
    vspeed = 0;
}

//if (hspd != 0) {
//	hspd -= fric;
//}

//if (vspd != 0) {
//	vspd -= fric;
//}

//vspd += grav;
//x += hspd;
//y += vspd;