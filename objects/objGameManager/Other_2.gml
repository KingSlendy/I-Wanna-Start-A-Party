audio_group_load(audiogroup_BGM);
audio_group_load(audiogroup_SFX);
global.buffer = buffer_create(1024, buffer_grow, 1);
room_goto_next();