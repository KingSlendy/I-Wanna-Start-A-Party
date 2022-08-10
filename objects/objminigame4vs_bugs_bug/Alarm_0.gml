next_seed_inline();
hspeed = irandom_range(-spd, spd);
vspeed = irandom_range(-spd, spd);
spd -= 0.5;
spd = max(spd, 1);
alarm[0] = irandom_range(get_frames(1), get_frames(5));