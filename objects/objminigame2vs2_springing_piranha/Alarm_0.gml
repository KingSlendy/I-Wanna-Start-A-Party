var f = instance_create_layer(x, y - 10, "Actors", objMinigame2vs2_Springing_Fireball);
f.hspeed = random_range(-5, 5);

if (f.hspeed == 0) {
	f.hspeed = choose(-1, 1);
}

f.vspeed = irandom_range(-7, -9);
f.gravity = 0.25;

alarm[0] = get_frames(0.15);