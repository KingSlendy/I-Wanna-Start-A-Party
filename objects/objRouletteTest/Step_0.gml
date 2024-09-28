roulette_angle = (roulette_angle - roulette_spd + 360) % 360;
roulette_spread = lerp(roulette_spread, (!roulette_chosen) ? 1 : 0, 0.05);

if (!roulette_chosen) {
	roulette_spd -= 0.005;
	roulette_spd = max(roulette_spd, 1);
} else {
	roulette_angle = max(roulette_angle, 270);
}