event_inherited();
part_emitter_destroy_safe(part_system, part_emitter);
part_type_destroy_safe(part_type);
part_system_destroy_safe(part_system);

if (audio_is_playing(sndMinigame1vs3_Conveyor_MovingLoop)) {
	audio_stop_sound(sndMinigame1vs3_Conveyor_MovingLoop);
}