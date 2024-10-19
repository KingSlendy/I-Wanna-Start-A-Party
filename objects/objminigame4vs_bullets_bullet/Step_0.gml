if (x <= 112 - sprite_width) {
	x = 112 + sprite_width * (instance_number(object_index) - 1);
	change_index();
	
	if (image_index == 1) {
		var bullet = instance_place(x - 1, y, objMinigame4vs_Bullets_Bullet);
	
		if (bullet != noone && bullet.image_index == 1) {
			instance_create_layer(x, y - 32 * 11, "Managers", objMinigame4vs_Bullets_Trophy, {
				image_xscale: 3,
				image_yscale: 10,
				hspeed: self.hspeed
			});
		}
	}
}