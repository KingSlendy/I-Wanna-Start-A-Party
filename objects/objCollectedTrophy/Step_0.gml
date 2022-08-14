if (sprite == null) {
	exit;
}

image_xscale = lerp(image_xscale, 0.5, 0.1);
image_yscale = image_xscale;
image_angle = lerp(image_angle, 0, 0.2);
	
if (disappear) {
	image_alpha -= 0.02;
		
	if (image_alpha <= 0) {
		instance_destroy();
	}
}