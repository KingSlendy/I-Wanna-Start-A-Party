//draw_surface(application_surface, 0, 0);

var text = new Text(global.fntControls);
text.set(draw_action_big(global.actions.right));
text.draw(751, 274);
text.set(draw_action_big(global.actions.up));
text.draw(380, 0);
text.set(draw_action_big(global.actions.left));
text.draw(0, 274);
text.set(draw_action_big(global.actions.down));
text.draw(380, 559);
text.set(draw_action_small(global.actions.shoot) + " " + language_get_text("WORD_GENERIC_MENU_CANCEL"));
text.draw(360, 520);