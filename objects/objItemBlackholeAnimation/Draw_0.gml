draw_sprite_ext(sprite, 0, current_player.x, current_player.y - 50, scale, scale, angle, c_white, 1);
angle = (angle + 1 + 360) % 360;
controls_text.set(draw_action_small(global.actions.jump) + " Mash");
controls_text.draw(current_player.x - 10, current_player.y + 30);