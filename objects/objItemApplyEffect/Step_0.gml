/// @description Timeline
if (timer >= total_duration) {
	instance_destroy();
	exit;
}

// Start gradient effect
if (timer < gradient_effect_duration) {
	yy.p_max = lerp(yy.p_max, y_target, timer / gradient_effect_duration);
}
	
if (timer > timer_spawn_particles[0] && timer < timer_spawn_particles[1] && timer % steps_spawn_particles == 0) {
	spawn_particles();
}
	
// Fade out the gradient
if (timer > fade_out[0] && timer < fade_out[1]) {
	var start_value = abs(timer - fade_out[0]);
	var finish_value = abs(timer - fade_out[1]);
	image_alpha = lerp(image_alpha, 0, start_value / finish_value);
}
	
timer++;