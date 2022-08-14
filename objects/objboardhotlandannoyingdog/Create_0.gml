event_inherited();
next_seed_inline();
x = choose(-sprite_width / 2, display_get_gui_width() + sprite_width / 2);
y = choose(-sprite_height / 2, display_get_gui_height() + sprite_height / 2);
xstart = x;
ystart = y;
image_xscale = (x > 400) ? -1 : 1;

with (focus_player) {
	other.nearest = instance_nearest(x, y, objShine);
}

target_x = nearest.x - camera_get_view_x(view_camera[0]);
target_y = nearest.y - camera_get_view_y(view_camera[0]);
target_state = 0;

music_pause();
audio_play_sound(bgmBoardHotlandAnnoyingDog, 0, true);

alarms_init(1);

alarm_create(function() {
	image_xscale *= -1;
	target_x = xstart;
	target_y = ystart;
	target_state = 1;
});