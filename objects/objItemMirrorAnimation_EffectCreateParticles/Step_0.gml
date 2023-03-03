if (timer_alpha_black_screen < duration_alpha_black_screen) {
    image_alpha = lerp(image_alpha, 0.5, timer_alpha_black_screen / duration_alpha_black_screen);
    timer_alpha_black_screen++;
}
 
if (++timer_burst == 3) {
    var y_off = 32;
    var side = choose(-1, 1);
    var xx = x + 400 + irandom_range(200, 400) * side;
    part_particles_create(part_system, xx, y + 608 + y_off, part_type[0], 1);
    
    side = choose(-1, 1);
    xx = x + 400 + irandom_range(200, 400) * side;
    part_particles_create(part_system, xx, y - y_off, part_type[1], 1);
    
    timer_burst = 0;
}