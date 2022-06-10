depth = -999;

show_popup("TIMES UP");
audio_play_sound(sndMinigameTimesUp, 0, false);
music_stop();
objPlayerBase.frozen = true;

view_visible[6] = true;
view_wport[6] = 352;
view_hport[6] = 160;
var camera = view_camera[6];
camera_set_view_size(camera, 352, 160);
camera_set_view_pos(camera, 1600 + 192 + 32, 128 + 16);
surf = noone;
view_alpha = 0;
view_start = false;
current_order = 0;

alarm[0] = get_frames(2);
