player_shot_time = array_create(global.player_max, 0);

take_time = true;
show_mark = true;
audio_play_sound(sndMinigame2vs2_Duel_Mark, 0, false);
alarm[5] = get_frames(3);
alarm[7] = get_frames(0.5);