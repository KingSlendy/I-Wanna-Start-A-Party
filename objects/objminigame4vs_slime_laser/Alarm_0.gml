scale -= 0.1;

if (scale <= 0) {
	instance_destroy();
	exit;
}

alarm[0] = 1;