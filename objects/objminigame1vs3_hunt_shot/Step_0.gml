image_xscale -= 0.05;
image_yscale = image_xscale;

if (image_xscale <= 0) {
	instance_destroy();
}