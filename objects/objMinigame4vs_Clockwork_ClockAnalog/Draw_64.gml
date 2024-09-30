draw_self();
draw_sprite_ext(sprMinigame4vs_Clockwork_HandMinutes, 0, x, y, 1, 1, -(minutes * 6), c_white, 1);
draw_sprite_ext(sprMinigame4vs_Clockwork_HandHours, 0, x, y, 1, 1, -((hour + minutes / 60) * 30), c_white, 1);