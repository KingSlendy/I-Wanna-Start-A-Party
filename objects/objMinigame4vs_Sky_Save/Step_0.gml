image_alpha += alpha_spd;
image_alpha = clamp(image_alpha, 0, 1);
image_xscale += scale_spd;
image_yscale += scale_spd;
scale_spd += 0.0005;

if (alpha_spd > 0 && image_xscale >= 3.5) {
	alpha_spd *= -3;
	depth = layer_get_depth("Actors") - 1;
	front = true;
}

if (image_alpha <= 0) {
	instance_destroy();
}