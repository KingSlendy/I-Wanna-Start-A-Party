if (shrink) {
	image_xscale -= 0.09;
	image_yscale -= 0.09;
	
	if (image_xscale <= 0) {
		instance_destroy();
	}
}