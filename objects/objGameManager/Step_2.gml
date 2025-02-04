//#region Music Loop System
//if (global.music_current != null && global.music_loop_start != -1) {
//    var current_position = audio_sound_get_track_position(global.music_current);
//    var total_length = global.music_loop_start + global.music_loop_end;

//    if (current_position > total_length) {
//        audio_sound_set_track_position(global.music_current, current_position - global.music_loop_end);    
//    }
//}
//#endregion