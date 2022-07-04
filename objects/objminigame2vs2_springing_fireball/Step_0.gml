image_xscale += 0.09;
image_yscale += 0.09;
image_angle += 3;

if (image_xscale >= 2) {
	depth = 100;
	image_xscale = 2;
	image_yscale = 2;
}