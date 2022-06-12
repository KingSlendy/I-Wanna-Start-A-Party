if (used) {
	image_xscale -= 0.04;
	image_yscale = image_xscale;
	
	if (image_xscale <= 0) {
		instance_destroy();
	}
	
	exit;
}

image_xscale += 0.02;
image_xscale = clamp(image_xscale, 0, 0.5);
image_yscale = image_xscale;